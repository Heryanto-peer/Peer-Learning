package common_model

type Chat struct {
	ChatID   string    `json:"chat_id" gorm:"primaryKey" binding:"required"`
	Fullname string `json:"fullname" binding:"required"`
	Content  string `json:"content" binding:"required"`
	ChatTime string `json:"chat_time" binding:"required"`
}
