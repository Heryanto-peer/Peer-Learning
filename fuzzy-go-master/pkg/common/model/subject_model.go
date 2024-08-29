package common_model

type Subject struct {
	SubjectID     string  `json:"subject_id" gorm:"primaryKey" binding:"required"`
	NIP           int     `json:"nip" gorm:"foreignKey:Teacher; column:nip"`
	SubjectName   string  `json:"subject_name" gorm:"unique" binding:"required"`
	SubjectLevel  int     `json:"subject_level" binding:"required"`
	SubjectMateri *string `json:"subject_materi" gorm:"column:subject_materi"`
}

type SubjectMateri struct {
	MateriID     string `json:"materi_id" binding:"required" gorm:"primaryKey"`
	PathMateri   string `json:"path_materi" binding:"required"`
	MateriName   string `json:"materi_name" binding:"required"`
	ActiveCourse string `json:"active_course" binding:"required"`
}

type SubjectInput struct {
	NIP          int    `json:"nip" binding:"required"`
	SubjectName  string `json:"subject_name" binding:"required"`
	SubjectLevel int    `json:"subject_level" binding:"required"`
}

type SubjectShow struct {
	SubjectID     string          `json:"subject_id"`
	SubjectName   string          `json:"subject_name"`
	SubjectLevel  int             `json:"subject_level"`
	TeacherName   *string         `json:"teacher_name" gorm:"foreignKey:Teacher"`
	SubjectMateri []SubjectMateri `json:"materis"`
}

type SubjectShowHolder struct {
	SubjectID     string  `json:"subject_id"`
	SubjectName   string  `json:"subject_name"`
	SubjectLevel  int     `json:"subject_level"`
	TeacherName   *string `json:"teacher_name" gorm:"foreignKey:Teacher"`
	SubjectMateri *string `json:"subject_materi"`
}

type SubjectUpdateTeacher struct {
	SubjectID string `json:"subject_id" binding:"required"`
	NewNIP    int    `json:"new_nip" binding:"required"`
}

type SubjectDetail struct {
	SubjectID    string  `json:"subject_id"`
	SubjectName  string  `json:"subject_name"`
	SubjectLevel int     `json:"subject_level"`
	TeacherName  *string `json:"teacher_name" gorm:"foreignKey:Teacher"`
}
