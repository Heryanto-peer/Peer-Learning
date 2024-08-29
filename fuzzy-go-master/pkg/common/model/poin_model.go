package common_model

type PoinHistory struct {
	DateCreated string `json:"date_created"`
	NIS         int    `json:"nis" gorm:"foreignkey:Student" binding:"required"`
	GroupID     string `json:"group_id" gorm:"foreignkey:Group" binding:"required"`
	PoinQuiz    string `json:"poin_quiz"`
}

type PoinHistoryInput struct {
	NIS      int     `json:"nis" gorm:"foreignkey:Student" binding:"required"`
	GroupID  *string `json:"group_id" gorm:"foreignkey:Group" binding:"required"`
	PoinQuiz int     `json:"poin_quiz" binding:"required"`
	PoinType string  `json:"poin_type" binding:"required"`
}

type PoinQuiz struct {
	DailyQuizPoin int `json:"daily_poin"`
	PostQuizPoin  int `json:"post_poin"`
	PreQuizPoin   int `json:"pre_poin"`
	FuzzyPoin     int `json:"fuzzy_poin"`
}
