package common_model

type Leaderboard struct {
	LeaderboardID string `json:"leaderboard_id" gorm:"primaryKey" binding:"required"`
	SubjectID     string `json:"subject_id" gorm:"foreignkey:Subject" binding:"required"`
	NIS           int    `json:"nis" gorm:"foreignkey:Student"`
	GroupID       *int   `json:"group_id" gorm:"foreignkey:Group"`
}

type LeaderboardGroupDetail struct {
	GroupID     string               `json:"group_id" gorm:"primaryKey" binding:"required"`
	GroupName   string               `json:"group_name" gorm:"unique" binding:"required"`
	SubjectName string               `json:"subject_name" gorm:"unique" binding:"required"`
	TotalPoin   int                  `json:"total_poin" binding:"required"`
	Contributed []StudentContributes `json:"contributed" binding:"required"`
}

type LeaderboardShow struct {
	ClassName              string                   `json:"class_name" gorm:"unique" binding:"required"`
	SubjectName            string                   `json:"subject_name" gorm:"unique" binding:"required"`
	LeaderboardGroupDetail []LeaderboardGroupDetail `json:"leaderboard_group_detail"`
}

type StudentContributes struct {
	NIS         int     `json:"nis" gorm:"primaryKey" binding:"required"`
	Fullname    string  `json:"fullname" binding:"required"`
	Contributes float64 `json:"contributes" binding:"required"`
}
