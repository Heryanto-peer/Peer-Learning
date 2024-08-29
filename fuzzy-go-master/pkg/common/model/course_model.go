package common_model

type SubjectCourse struct {
	SubjectID   *string `json:"subject_id" binding:"required" `
	ClassID     *string `json:"class_id" gorm:"primaryKey; unique" binding:"required"`
	StartCourse *string `json:"start_course" `
	EndCourse   *string `json:"end_course" `
}
