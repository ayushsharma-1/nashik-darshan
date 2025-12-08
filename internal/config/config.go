package config

import (
	"encoding/json"
	"errors"
	"fmt"
	"strings"

	"github.com/joho/godotenv"
	"github.com/omkar273/nashikdarshan/internal/types"
	"github.com/omkar273/nashikdarshan/internal/validator"
	"github.com/spf13/viper"
)

type Configuration struct {
	Server   ServerConfig   `validate:"required"`
	Logging  LoggingConfig  `validate:"required"`
	Postgres PostgresConfig `validate:"required"`
	Supabase SupabaseConfig `validate:"required"`
	Secrets  SecretsConfig  `validate:"required"`
	Routing  RoutingConfig  `validate:"required"`
}

type LoggingConfig struct {
	Level types.LogLevel `mapstructure:"level" validate:"required"`
}

type Env string

const (
	EnvLocal Env = "local"
	EnvDev   Env = "dev"
	EnvProd  Env = "prod"
)

type ServerConfig struct {
	Env     Env    `mapstructure:"env" validate:"required"`
	Address string `mapstructure:"address" validate:"required"`
}

type PostgresConfig struct {
	Host                   string `mapstructure:"host" validate:"required"`
	Port                   int    `mapstructure:"port" validate:"required"`
	User                   string `mapstructure:"user" validate:"required"`
	Password               string `mapstructure:"password" validate:"required"`
	DBName                 string `mapstructure:"dbname" validate:"required"`
	SSLMode                string `mapstructure:"sslmode" validate:"required"`
	MaxOpenConns           int    `mapstructure:"max_open_conns" default:"10"`
	MaxIdleConns           int    `mapstructure:"max_idle_conns" default:"5"`
	ConnMaxLifetimeMinutes int    `mapstructure:"conn_max_lifetime_minutes" default:"60"`
	AutoMigrate            bool   `mapstructure:"auto_migrate" default:"false"`
}

type SecretsConfig struct {
	EncryptionKey string `mapstructure:"encryption_key" validate:"required"`
}

type SupabaseConfig struct {
	URL            string `mapstructure:"url" validate:"required"`
	PublishableKey string `mapstructure:"publishable_key" validate:"required"` // For client-side use
	SecretKey      string `mapstructure:"secret_key" validate:"required"`      // For server-side use
}

type RoutingConfig struct {
	Provider string `mapstructure:"provider"` // e.g., "google_maps". Optional - when empty routing is disabled
	APIKey   string `mapstructure:"api_key"`
	Timeout  int    `mapstructure:"timeout" default:"30"` // Timeout in seconds
}

func NewConfig() (*Configuration, error) {
	v := viper.New()

	// Step 1: Load `.env` if it exists
	envLoaded := godotenv.Load() == nil

	// Step 2: Initialize Viper
	v.SetConfigName("config")
	v.SetConfigType("yaml")
	v.AddConfigPath("./internal/config")
	v.AddConfigPath("./config")

	// Step 3: Set up environment variables support
	v.SetEnvPrefix("CAYGNUS")
	v.AutomaticEnv()

	// Step 4: Environment variable key mapping (e.g., CAYGNUS_SUPABASE_URL)
	v.SetEnvKeyReplacer(strings.NewReplacer(".", "_"))

	// Step 5: Read the YAML file
	configFileFound := true
	if err := v.ReadInConfig(); err != nil {
		if errors.As(err, &viper.ConfigFileNotFoundError{}) {
			configFileFound = false
			fmt.Printf("Warning: No config file found\n")
		} else {
			return nil, fmt.Errorf("error reading config file: %v", err)
		}
	} else {
		fmt.Printf("Using config file: %s\n", v.ConfigFileUsed())
	}

	// Check if we have any configuration source
	if !configFileFound && !envLoaded {
		fmt.Printf("Warning: Neither config.yaml nor .env file found. Checking environment variables...\n")
	}

	var cfg Configuration
	if err := v.Unmarshal(&cfg); err != nil {
		return nil, fmt.Errorf("unable to decode into config struct, %v", err)
	}

	// Step 7: Validate the configuration
	if err := cfg.Validate(); err != nil {
		return nil, fmt.Errorf("configuration validation failed: %v\n\nPlease ensure you have either:\n1. A valid config.yaml file in ./internal/config/ or ./config/\n2. A .env file with required variables\n3. Environment variables with CAYGNUS_ prefix\n\nRequired fields: server.address, logging.level, postgres.host, postgres.port, postgres.user, postgres.password, postgres.dbname, postgres.sslmode, supabase.url, supabase.publishable_key, supabase.secret_key, secrets.encryption_key", err)
	}

	// print the config in json format for debugging during development
	jsonConfig, err := json.MarshalIndent(cfg, "", "  ")
	if err != nil {
		fmt.Printf("Error marshalling config to JSON: %v\n", err)
	}
	if cfg.Server.Env == EnvDev {
		fmt.Printf("Config: %s\n\n", string(jsonConfig))
	}

	return &cfg, nil
}

func (c Configuration) Validate() error {
	// First validate core configuration ignoring routing specific required checks
	// Create a shallow copy with routing zeroed-out to avoid failing on optional routing
	tmp := c
	// zero-out routing to skip generic required validation on those fields
	tmp.Routing = RoutingConfig{}

	if err := validator.ValidateRequest(tmp); err != nil {
		return err
	}

	// Conditional validation for Routing
	// If a provider is specified and it's google_maps, APIKey must be present
	if strings.TrimSpace(c.Routing.Provider) != "" {
		provider := strings.ToLower(strings.TrimSpace(c.Routing.Provider))
		switch provider {
		case "google_maps":
			if strings.TrimSpace(c.Routing.APIKey) == "" {
				return fmt.Errorf("routing.api_key is required when routing.provider is 'google_maps'")
			}
		default:
			// For unknown providers we allow configuration but log a hint (no error)
		}
	}

	return nil
}

// GetDefaultConfig returns a default configuration for local development
// This is useful for running scripts or other non-web applications
func GetDefaultConfig() *Configuration {
	return &Configuration{
		Server: ServerConfig{
			Address: ":8080",
		},
		Logging: LoggingConfig{
			Level: types.LogLevelDebug,
		},
	}
}

// GetDSN returns the database connection string (DSN) for direct PostgreSQL connections
func (p PostgresConfig) GetDSN() string {
	// Build base DSN
	dsn := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=%s",
		p.Host,
		p.Port,
		p.User,
		p.Password,
		p.DBName,
		p.SSLMode,
	)

	// Add channel_binding for Neon if sslmode is require
	if p.SSLMode == "require" {
		dsn += " channel_binding=require"
	}

	return dsn
}
