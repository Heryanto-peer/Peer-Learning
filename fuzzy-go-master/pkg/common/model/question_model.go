package common_model

type Question struct {
	QuestionID string `json:"question_id" gorm:"primaryKey" binding:"required"`
	SubjectID  string `json:"subject_id" gorm:"foreignkey:Subject"`
	Question   string `json:"question" binding:"required"`
	Answer     string `json:"answer" binding:"required"`
	Option1    string `json:"option1" binding:"required"`
	Option2    string `json:"option2" binding:"required"`
	Option3    string `json:"option3" binding:"required"`
	Option4    string `json:"option4" binding:"required"`
	Poin       int    `json:"poin" binding:"required"`
	Type       string `json:"type" binding:"required"`
	Tips       string `json:"tips"`
}
type QuestionShow struct {
	QuestionID string `json:"question_id"`
	Question   string `json:"question"`
	Answer     string `json:"answer"`
	Option1    string `json:"option1"`
	Option2    string `json:"option2"`
	Option3    string `json:"option3"`
	Option4    string `json:"option4"`
	Poin       int    `json:"poin"`
	Type       string `json:"type"`
	Tips       string `json:"tips"`
}

type QuestionInput struct {
	SubjectID string `json:"subject_id" binding:"required"`
	Question  string `json:"question" binding:"required"`
	Answer    string `json:"answer" binding:"required"`
	Option1   string `json:"option1" binding:"required"`
	Option2   string `json:"option2" binding:"required"`
	Option3   string `json:"option3" binding:"required"`
	Option4   string `json:"option4" binding:"required"`
	Poin      int    `json:"poin" binding:"required"`
	Type      string `json:"type" binding:"required"`
	Tips      string `json:"tips"`
}

type QuestionUpdate struct {
	QuestionID string  `json:"question_id"`
	Question   *string `json:"question" `
	Answer     *string `json:"answer" `
	Option1    *string `json:"option1" `
	Option2    *string `json:"option2"`
	Option3    *string `json:"option3"`
	Option4    *string `json:"option4" `
	Poin       *int    `json:"poin"`
	Type       *string `json:"type" `
	Tips       *string `json:"tips"`
}

type SubjectWithQuestion struct {
	SubjectID    string `json:"subject_id"`
	SubjectName  string `json:"subject_name"`
	SubjectLevel int    `json:"subject_level"`
	Question     []QuestionShow
}
