package common_model

type Class struct {
	ClassID       string `json:"class_id" gorm:"primaryKey" binding:"required" `
	Advisor       int    `json:"nip" gorm:"foreignkey:Teacher" binding:"required"`
	ClassName     string `json:"class_name" gorm:"unique" binding:"required"`
	LeaderboardID *int   `json:"leaderboard_id" gorm:"foreignkey:Leaderboard"`
}

type ClassMember struct {
	ClassID   string        `json:"class_id" gorm:"primaryKey" binding:"required"`
	Advisor   int           `json:"nip" binding:"required"`
	ClassName string        `json:"class_name" gorm:"unique" binding:"required"`
	Students  []StudentShow `json:"students" gorm:"foreignkey:Student"`
}

type GroupClassMember struct {
	ClassID   string        `json:"class_id" gorm:"primaryKey" binding:"required"`
	Advisor   int           `json:"nip" binding:"required"`
	ClassName string        `json:"class_name" gorm:"unique" binding:"required"`
	Groups    []GroupMember `json:"groups" gorm:"foreignkey:Student"`
}

type ClassInput struct {
	Advisor   int    `json:"nip" binding:"required"`
	ClassName string `json:"class_name" binding:"required"`
}

type ClasInitial struct {
	ClassID   string `json:"class_id" gorm:"primaryKey" binding:"required" `
	Advisor   int    `json:"nip" gorm:"foreignkey:Teacher" binding:"required"`
	ClassName string `json:"class_name" gorm:"unique" binding:"required"`
}
