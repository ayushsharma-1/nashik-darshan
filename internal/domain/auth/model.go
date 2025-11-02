package auth

type Claims struct {
	UserID string `json:"user_id"`
	Email  string `json:"email"`
}
