package user_module

import (
	model "fuzzy/pkg/common/model"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

// remove Teacher data by nip and code
func RemoveTeacher(c *gin.Context) {
	var TeacherTable model.Teacher

	if c.PostForm("code") != "please remove this teacher" {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Cannot remove this teacher",
			Data:    nil,
		})
		return
	}

	id, err := strconv.Atoi(c.PostForm("nip"))
	if err != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("nip = ?", id).First(&TeacherTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    nil,
		})
		return
	}

	if db.Delete(model.Teacher{}, "nip = ?", id).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to remove Teacher",
			Data:    nil,
		})
		return
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    nil,
	})
}

// update password Teacher data by nip and password
func TeacherUpdatePassword(c *gin.Context) {
	var TeacherTable model.Teacher
	var input model.TeacherUpdatePasswordInput

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("nip = ? AND password = ?", input.NIP, input.OldPassword).First(&TeacherTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    nil,
		})
		return
	}

	if db.Model(&TeacherTable).Where("nip = ?", input.NIP).Update("password", input.NewPassword).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to update Teacher password",
			Data:    nil,
		})
		return
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    nil,
	})
}

// update image Teacher data by nip and password
func TeacherUpdateImage(c *gin.Context) {
	var TeacherTable model.Teacher
	var TeacherShow model.TeacherShow
	var input model.TeacherUpdateImageInput

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("nip = ? AND password = ?", input.NIP, input.Password).First(&TeacherTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    nil,
		})
		return
	}

	if db.Model(&TeacherTable).Where("nip = ?", input.NIP).Update("image_profile", input.ImageProfile).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to update Teacher image",
			Data:    nil,
		})
		return
	}

	TeacherShow = model.TeacherShow{
		NIP:          TeacherTable.NIP,
		Fullname:     TeacherTable.Fullname,
		ImageProfile: TeacherTable.ImageProfile,
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    TeacherShow,
	})
}

// get subject by nip
func TeacherSubject(NIP int, db *gorm.DB) *model.Subject {
	subject, err := db.Model(&model.Subject{}).Where("nip = ?", NIP).First(&model.Subject{}).Value.(*model.Subject)
	if err {
		return nil
	}
	return subject
}

// get all Teacher data
func AllTeacher(c *gin.Context) {
	var TeacherList []model.TeacherShow
	var table []model.Teacher

	db := c.MustGet("db").(*gorm.DB)
	if db.Find(&table).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    []model.TeacherShow{},
		})
		return
	}

	for _, teacher := range table {
		TeacherList = append(TeacherList, model.TeacherShow{
			NIP:          teacher.NIP,
			Fullname:     teacher.Fullname,
			ImageProfile: teacher.ImageProfile,
			Subject:      TeacherSubject(teacher.NIP, db),
		})
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    TeacherList,
	})
}
