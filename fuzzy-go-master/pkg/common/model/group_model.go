package common_model

type Group struct {
	GroupID string `json:"group_id" gorm:"primaryKey; unique" binding:"required" `
	ClassID string `json:"class_id" gorm:"foreignkey:Class"`
	// SubjectID string  `json:"subject_id" gorm:"foreignkey:Subject"`
	ChatID    *string `json:"chat_id" gorm:"foreignkey:Chat"`
	GroupName string  `json:"group_name" binding:"required"`
	TotalPoin *int    `json:"total_poin"`
}

type GroupInput struct {
	ClassID string `json:"class_id"  binding:"required"`
	// SubjectID string `json:"subject_id"  binding:"required"`
	GroupName string `json:"group_name" binding:"required"`
}

type GroupMember struct {
	GroupID     string    `json:"group_id" gorm:"primaryKey" binding:"required" `
	ClassID     *string   `json:"class_id" gorm:"foreignkey:Class"`
	GroupName   string    `json:"group_name" binding:"required"`
	ClassName   string    `json:"class_name"  binding:"required"`
	ListStudent []Student `json:"list_Student" gorm:"foreignkey:Student"`
}

type GroupInitial struct {
	GroupID   string `json:"group_id" gorm:"primaryKey" binding:"required" `
	GroupName string `json:"group_name" binding:"required"`
}
