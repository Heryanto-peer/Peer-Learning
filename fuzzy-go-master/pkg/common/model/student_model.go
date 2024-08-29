package common_model

type Student struct {
	NIS          int      `json:"nis" gorm:"primaryKey; unique; column:nis" binding:"required" `
	Fullname     string   `json:"fullname" binding:"required"`
	Password     string   `json:"password" binding:"required"`
	ClassID      *string  `json:"class_id" gorm:"association_foreignkey:Class"`
	GroupID      *string  `json:"group_id" gorm:"foreignkey:Group"`
	ImageProfile *string  `json:"image_profile"`
	Contributes  *float64 `json:"contributes"`
	LatestDaily  *string  `json:"latest_daily"`
	AssesmentID  *string  `json:"assesment_id" gorm:"association_foreignkey:Assesment"`
}

type StudentUpdate struct {
	Fullname     string   `json:"fullname"`
	Password     string   `json:"password"`
	ImageProfile *string  `json:"image_profile"`
	GroupID      *string  `json:"group_id"`
	ClassID      *string  `json:"class_id"`
	Contributes  *float64 `json:"contributes"`
}

type StudentShow struct {
	NIS          int           `json:"nis" gorm:"primaryKey" binding:"required" `
	Fullname     string        `json:"fullname" binding:"required"`
	ImageProfile *string       `json:"image_profile"`
	Group        *GroupInitial `json:"group"`
	Contributes  *float64      `json:"contributes"`
	LatestDaily  *string       `json:"latest_daily"`
}

type StudentShowDetail struct {
	NIS          int           `json:"nis" gorm:"primaryKey" binding:"required" `
	Fullname     string        `json:"fullname" binding:"required"`
	Class        *ClasInitial  `json:"class"`
	Group        *GroupInitial `json:"group"`
	ImageProfile *string       `json:"image_profile"`
	Contributes  *float64      `json:"contributes"`
	LatestDaily  *string       `json:"latest_daily"`
	AssesmentID  *string       `json:"assesment_id" gorm:"association_foreignkey:Assesment"`
}

type StudentLoginInput struct {
	NIS      int    `json:"nis" gorm:"primaryKey" binding:"required" `
	Password string `json:"password" binding:"required"`
}

type StudentRegisterInput struct {
	NIS          int     `json:"nis" gorm:"primaryKey" binding:"required" `
	Fullname     string  `json:"fullname" gorm:"unique" binding:"required"`
	Password     string  `json:"password" binding:"required"`
	ImageProfile *string `json:"image_profile"`
	GroupID      *string `json:"group_id" gorm:"foreignkey:Group"`
	ClassID      *string `json:"class_id" gorm:"foreignkey:Class"`
}

type StudentUpdateInput struct {
	NIS          int      `json:"nis" gorm:"primaryKey" binding:"required" `
	KeyPas       string   `json:"key_pas" binding:"required"`
	Password     string   `json:"password" binding:"required"`
	Fullname     *string  `json:"fullname"`
	ImageProfile *string  `json:"image_profile"`
	Contributes  *float64 `json:"contributes"`
}

type StudentTypeInput struct {
	NIS      int    `json:"nis" gorm:"primaryKey" binding:"required" `
	Password string `json:"password" binding:"required"`
}

type StudentPasswordInput struct {
	NIS         int    `json:"nis" gorm:"primaryKey" binding:"required" `
	OldPassword string `json:"old_password" binding:"required"`
	NewPassword string `json:"new_password" binding:"required"`
}

type StudentDetail struct {
	NIS          int          `json:"nis" gorm:"primaryKey" binding:"required" `
	Fullname     string       `json:"fullname" binding:"required"`
	Password     string       `json:"password" binding:"required"`
	Class        ClasInitial  `json:"class"`
	Group        GroupInitial `json:"group"`
	ImageProfile *string      `json:"image_profile"`
	Contributes  *int         `json:"contributes"`
	LatestDaily  *string      `json:"latest_daily"`
	AssesmentID  *string      `json:"assesment_id" gorm:"association_foreignkey:Assesment"`
}

type InputGroupStudent struct {
	GroupID string   `json:"group_id" binding:"required"`
	NIS     []string `json:"nis" binding:"required"`
}
