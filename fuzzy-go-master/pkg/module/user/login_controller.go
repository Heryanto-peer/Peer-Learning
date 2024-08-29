package user_module

import (
	model "fuzzy/pkg/common/model"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func StudentLogin(c *gin.Context) {
	var StudentTable model.Student
	var Student model.StudentShowDetail

	id, err := strconv.Atoi(c.PostForm("nis"))
	if err != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	input := model.StudentLoginInput{NIS: id, Password: c.PostForm("password")}
	db := c.MustGet("db").(*gorm.DB)
	if db.Where("nis = ? AND password = ?", input.NIS, input.Password).First(&StudentTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Student not found",
			Data:    nil,
		})
		return
	}

	Student = model.StudentShowDetail{
		NIS:          StudentTable.NIS,
		Fullname:     StudentTable.Fullname,
		ImageProfile: StudentTable.ImageProfile,
	}

	if StudentTable.ClassID != nil {
		class := []model.ClasInitial{}
		db.Where("class_id = ?", *StudentTable.ClassID).Find(&model.Class{}).Scan(&class)
		for _, v := range class {
			Student.Class = &v
		}
	}

	if StudentTable.GroupID != nil {
		group := []model.GroupInitial{}
		db.Where("group_id = ?", *StudentTable.GroupID).Find(&model.Group{}).Scan(&group)
		for _, v := range group {
			Student.Group = &v
		}
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    Student,
	})
}

func TeacherLogin(c *gin.Context) {
	var TeacherTable model.Teacher
	var Teacher model.TeacherShow

	id, err := strconv.Atoi(c.PostForm("nip"))
	if err != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	input := model.TeacherLoginInput{NIP: id, Password: c.PostForm("password")}
	db := c.MustGet("db").(*gorm.DB)
	if db.Where("nip = ? AND password = ?", input.NIP, input.Password).First(&TeacherTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    nil,
		})
		return
	}

	Teacher = model.TeacherShow{
		NIP:          TeacherTable.NIP,
		Fullname:     TeacherTable.Fullname,
		ImageProfile: TeacherTable.ImageProfile,
	}

	if TeacherTable.ClassID != nil {
		class := []model.Class{}
		db.Where("class_id = ?", *TeacherTable.ClassID).Find(&class).First(&Teacher.Advisor)

	}

	subject := []model.Subject{}
	if db.Where("nip = ?", TeacherTable.NIP).Find(&subject).First(&Teacher.Subject).Error != nil {
		Teacher.Subject = nil
	} else {
		db.Where("subject_id = ?", *Teacher.Subject).First(&Teacher.Subject)

	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    Teacher,
	})
}
