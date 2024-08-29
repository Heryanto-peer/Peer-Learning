package common_model

type Assesment struct {
	AssesmentID string `json:"assesment_id" gorm:"primaryKey" binding:"required" `
	GroupID     string `json:"group_id" gorm:"foreignkey:Group" binding:"required" `
	SubjectID   string `json:"subject_id" gorm:"foreignkey:Subject" binding:"required" `
	NIS         int    `json:"nis" gorm:"foreignkey:Student" binding:"required" `
	Assesments  string `json:"assesments"`
	DATECREATED string `json:"date_created" gorm:"column:date_created"`
}

type AssesmentInput struct {
	GroupID     string          `json:"group_id" gorm:"foreignkey:Group" binding:"required" `
	SubjectID   string          `json:"subject_id" gorm:"foreignkey:Subject" binding:"required" `
	NIS         int             `json:"nis" gorm:"foreignkey:Student" binding:"required" `
	Assesments  []PoinAssesment `json:"assesments" binding:"required"`
	DATECREATED string          `json:"date_created"`
}

type AssesmentShow struct {
	AssesmentID string          `json:"assesment_id" gorm:"primaryKey" binding:"required" `
	GroupName   string          `json:"group_name"`
	SubjectName string          `json:"subject_name"`
	NIS         int             `json:"nis" `
	Assesments  []PoinAssesment `json:"assesments"`
	DATECREATED string          `json:"date_created"`
}

type AssesmentUpdate struct {
	AssesmentID string          `json:"assesment_id" gorm:"primaryKey" binding:"required" `
	Assesments  []PoinAssesment `json:"assesments"`
}

type PoinAssesment struct {
	NIS         int    `json:"nis" gorm:"foreignkey:Student" binding:"required" `
	Fullname    string `json:"fullname"`
	Significant *int   `json:"significant"`
	Helpful     *int   `json:"helpful"`
}
