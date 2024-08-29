package user_module

import (
	model "fuzzy/pkg/common/model"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func StudentRegister(c *gin.Context) {
	var StudentTable model.Student
	var Student model.StudentShow
	var input model.StudentRegisterInput

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)

	// check if class already exist
	if input.ClassID != nil {
		if db.Where("class_id = ?", input.ClassID).First(&model.Class{}).Error != nil {
			c.JSON(http.StatusNotFound, model.MainModel{
				Status:  http.StatusNotFound,
				Message: "Class not found",
				Data:    nil,
			})
			return
		}
	}

	// check if group already exist
	if input.GroupID != nil {
		if db.Where("group_id = ?", input.GroupID).First(&model.Group{}).Error != nil {
			c.JSON(http.StatusNotFound, model.MainModel{
				Status:  http.StatusNotFound,
				Message: "Group not found",
				Data:    nil,
			})
			return
		}
	}

	if db.Where("nis = ? OR fullname = ?", input.NIS, input.Fullname).First(&StudentTable).Error == nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Student already exist",
			Data:    nil,
		})
		return
	}

	StudentTable = model.Student{
		NIS:          input.NIS,
		Fullname:     input.Fullname,
		Password:     input.Password,
		ImageProfile: input.ImageProfile,
		GroupID:      input.GroupID,
		ClassID:      input.ClassID,
	}

	if db.Create(&StudentTable).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to create Student",
			Data:    nil,
		})
		return
	}

	Student = model.StudentShow{
		NIS:          StudentTable.NIS,
		Fullname:     StudentTable.Fullname,
		ImageProfile: StudentTable.ImageProfile,
		Contributes:  StudentTable.Contributes,
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    Student,
	})
}

func TeacherRegister(c *gin.Context) {
	var TeacherTable model.Teacher
	var Teacher model.TeacherShow
	var input model.TeacherRegisterInput

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("nip = ? OR password = ?", input.NIP, input.Password).First(&TeacherTable).Error == nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher already exist",
			Data:    nil,
		})
		return
	}

	TeacherTable = model.Teacher{
		NIP:      input.NIP,
		Fullname: input.Fullname,
		Password: input.Password,
	}

	if db.Create(&TeacherTable).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to create Teacher",
			Data:    nil,
		})
		return
	}

	Teacher = model.TeacherShow{
		NIP:      TeacherTable.NIP,
		Fullname: TeacherTable.Fullname,
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    Teacher,
	})
}
