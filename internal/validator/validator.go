package validator

import (
	"errors"
	"fmt"
	"regexp"
	"strings"
	"sync"

	"github.com/go-playground/validator/v10"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
)

var (
	validate *validator.Validate
	once     sync.Once

	// Regex for slug validation (kebab-case: lowercase alphanumeric with hyphens)
	slugRegex = regexp.MustCompile(`^[a-z0-9]+(?:-[a-z0-9]+)*$`)

	// ISO 4217 currency codes (commonly used ones)
	validCurrencies = map[string]bool{
		"USD": true, "EUR": true, "GBP": true, "JPY": true,
		"INR": true, "AUD": true, "CAD": true, "CHF": true,
		"CNY": true, "SEK": true, "NZD": true, "MXN": true,
		"SGD": true, "HKD": true, "NOK": true, "KRW": true,
		"TRY": true, "RUB": true, "BRL": true, "ZAR": true,
		"DKK": true, "PLN": true, "TWD": true, "THB": true,
		"MYR": true, "IDR": true, "AED": true, "SAR": true,
	}
)

// initValidator initializes the validator exactly once
func initValidator() {
	once.Do(func() {
		validate = validator.New()
	})
}

func NewValidator() *validator.Validate {
	initValidator()
	return validate
}

func GetValidator() *validator.Validate {
	initValidator()
	return validate
}

func ValidateRequest(req interface{}) error {
	initValidator()

	if err := validate.Struct(req); err != nil {
		details := make(map[string]any)
		var validateErrs validator.ValidationErrors
		if errors.As(err, &validateErrs) {
			for _, err := range validateErrs {
				details[err.Field()] = err.Error()
			}
		}
		return ierr.WithError(err).
			WithHint("Request validation failed").
			WithReportableDetails(details).
			Mark(ierr.ErrValidation)
	}
	return nil
}

// ValidateSlugFormat validates that a slug follows kebab-case format
// (lowercase alphanumeric characters with hyphens, no leading/trailing hyphens)
func ValidateSlugFormat(slug string) error {
	// Trim whitespace
	slug = strings.TrimSpace(slug)

	if slug == "" {
		return ierr.NewError("slug cannot be empty").
			WithHint("Please provide a valid slug").
			Mark(ierr.ErrValidation)
	}

	// Check for leading or trailing hyphens
	if strings.HasPrefix(slug, "-") || strings.HasSuffix(slug, "-") {
		return ierr.NewError("slug cannot start or end with a hyphen").
			WithHint("Please use kebab-case format (e.g., 'my-hotel-name')").
			Mark(ierr.ErrValidation)
	}

	// Validate format using regex
	if !slugRegex.MatchString(slug) {
		return ierr.NewError("slug must be in kebab-case format").
			WithHint("Use only lowercase letters, numbers, and hyphens (e.g., 'nashik-grand-hotel')").
			Mark(ierr.ErrValidation)
	}

	// Check for consecutive hyphens
	if strings.Contains(slug, "--") {
		return ierr.NewError("slug cannot contain consecutive hyphens").
			WithHint("Please use single hyphens to separate words").
			Mark(ierr.ErrValidation)
	}

	return nil
}

// ValidateCurrencyCode validates that a currency code is a valid ISO 4217 code
func ValidateCurrencyCode(currency string) error {
	// Convert to uppercase for validation
	currency = strings.ToUpper(strings.TrimSpace(currency))

	if currency == "" {
		return nil // Empty is acceptable for optional field
	}

	// Check length (ISO 4217 codes are always 3 characters)
	if len(currency) != 3 {
		return ierr.NewError("currency code must be 3 characters").
			WithHint("Please use ISO 4217 currency codes (e.g., 'USD', 'INR', 'EUR')").
			Mark(ierr.ErrValidation)
	}

	// Check if it's a valid currency code
	if !validCurrencies[currency] {
		return ierr.NewError(fmt.Sprintf("invalid currency code: %s", currency)).
			WithHint("Please use standard ISO 4217 currency codes like USD, EUR, GBP, INR").
			Mark(ierr.ErrValidation)
	}

	return nil
}
