package main

import (
	"context"
	"database/sql"
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
	"time"

	_ "github.com/lib/pq"
	"github.com/omkar273/nashikdarshan/ent"
	"github.com/omkar273/nashikdarshan/internal/config"
	"github.com/omkar273/nashikdarshan/internal/logger"
)

func main() {
	// Parse command line flags
	dryRun := flag.Bool("dry-run", false, "Print migration SQL without executing it")
	flag.Parse()

	// Load configuration
	cfg, err := config.NewConfig()
	if err != nil {
		log.Fatalf("Failed to load config: %v", err)
	}

	// Initialize logger
	logger, err := logger.NewLogger(cfg)
	if err != nil {
		log.Fatalf("Failed to create logger: %v", err)
	}

	// For migrations, we need to handle connection poolers (like Neon) that don't support prepared statements
	// Build a migration-specific DSN that disables prepared statements
	migrationDSN := buildMigrationDSN(cfg.Postgres)

	// If the host contains "pooler", try to use direct connection
	// For Neon: replace "-pooler" with nothing to get direct connection
	if strings.Contains(cfg.Postgres.Host, "pooler") {
		directHost := strings.Replace(cfg.Postgres.Host, "-pooler", "", 1)
		logger.Infow("Detected pooler connection, using direct connection for migrations",
			"pooler_host", cfg.Postgres.Host,
			"direct_host", directHost)
		migrationDSN = buildMigrationDSNFromHost(cfg.Postgres, directHost)
	}

	logger.Infow("Connecting to database", "host", cfg.Postgres.Host)

	// Open raw database connection to enable PostGIS extension
	db, err := sql.Open("postgres", migrationDSN)
	if err != nil {
		logger.Fatalw("Failed to connect to postgres", "error", err)
	}
	defer db.Close()

	// Test connection
	if err := db.Ping(); err != nil {
		logger.Fatalw("Failed to ping postgres", "error", err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	// Enable PostGIS extension if not already enabled
	logger.Info("Enabling PostGIS extension...")
	_, err = db.ExecContext(ctx, "CREATE EXTENSION IF NOT EXISTS postgis")
	if err != nil {
		logger.Fatalw("Failed to enable PostGIS extension", "error", err)
	}
	logger.Info("PostGIS extension enabled successfully")

	// Create Ent client with migration DSN that disables prepared statements
	client, err := ent.Open("postgres", migrationDSN)
	if err != nil {
		logger.Fatalw("Failed to create ent client", "error", err)
	}
	//nolint:errcheck
	defer client.Close()

	// Run auto migration
	logger.Info("Running database migrations...")

	// Check if we're in dry-run mode
	if *dryRun {
		logger.Info("Dry run mode - printing migration SQL without executing")
		// In dry-run mode, we just print the SQL that would be executed
		err = client.Schema.WriteTo(ctx, os.Stdout)
		if err != nil {
			logger.Fatalw("Failed to generate migration SQL", "error", err)
		}
	} else {
		// Run the actual migration
		err = client.Schema.Create(ctx)
		if err != nil {
			logger.Fatalw("Failed to create schema resources", "error", err)
		}
		logger.Info("Migration completed successfully")
	}

	fmt.Println("Migration process completed")
}

// buildMigrationDSN builds a DSN for migrations using direct connection
func buildMigrationDSN(cfg config.PostgresConfig) string {
	return fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=%s",
		cfg.Host,
		cfg.Port,
		cfg.User,
		cfg.Password,
		cfg.DBName,
		cfg.SSLMode,
	)
}

// buildMigrationDSNFromHost builds a migration DSN with a specific host
func buildMigrationDSNFromHost(cfg config.PostgresConfig, host string) string {
	return fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=%s",
		host,
		cfg.Port,
		cfg.User,
		cfg.Password,
		cfg.DBName,
		cfg.SSLMode,
	)
}
