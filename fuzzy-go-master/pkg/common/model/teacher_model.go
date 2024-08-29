package common_model

type Teacher struct {
	NIP          int     `json:"nip" gorm:"primaryKey; unique; column:nip" binding:"required" `
	ClassID      *string    `json:"class_id" gorm:"foreignKey:Class; column:class_id"`
	Class        *Class  `json:"class" gorm:"foreignKey:ClassID"`
	Fullname     string  `json:"fullname" binding:"required"`
	Password     string  `json:"password" binding:"required"`
	ImageProfile *string `json:"image_profile"`
}

type TeacherShow struct {
	NIP          int      `json:"nip"`
	Fullname     string   `json:"fullname"`
	ImageProfile *string  `json:"image_profile"`
	Advisor      *string  `json:"class_name" gorm:"foreignKey:Class"`
	Subject      *Subject `json:"subject" gorm:"foreignKey:Subject"`
}

type TeacherLoginInput struct {
	NIP      int    `json:"nip" gorm:"primaryKey" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type TeacherRegisterInput struct {
	NIP      int    `json:"nip" gorm:"primaryKey, unique" binding:"required"`
	Fullname string `json:"fullname" gorm:"unique" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type TeacherUpdatePasswordInput struct {
	NIP         int    `json:"nip" gorm:"primaryKey" binding:"required"`
	OldPassword string `json:"old_password" binding:"required"`
	NewPassword string `json:"new_password" binding:"required"`
}

type TeacherUpdateImageInput struct {
	NIP          int    `json:"nip" gorm:"primaryKey" binding:"required"`
	Password     string `json:"password" binding:"required"`
	ImageProfile string `json:"image_profile" binding:"required"`
}
