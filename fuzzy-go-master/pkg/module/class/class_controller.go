package class_module

import (
	"fmt"
	controller "fuzzy/pkg/common/controller"
	model "fuzzy/pkg/common/model"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

// / add a new class with the advisor
func AddClass(c *gin.Context) {
	var ClassTable model.Class
	var input model.ClassInput

	err := c.ShouldBindJSON(&input)
	if err != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)

	/// check if teacher exist
	if db.Where("nip = ?", input.Advisor).First(&model.Teacher{}).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    nil,
		})
		return
	}

	/// check if class exist
	if db.Where("class_name = ?", input.ClassName).First(&model.Class{}).Error == nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Class already exist",
			Data:    nil,
		})
		return
	}

	id := controller.GenerateRandomID(30)
	ClassTable = model.Class{
		ClassID:   id,
		Advisor:   input.Advisor,
		ClassName: input.ClassName,
	}

	if db.Create(&ClassTable).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to add new class",
			Data:    nil,
		})
		return
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: fmt.Sprintf("Success add new class %s", input.ClassName),
		Data:    ClassTable,
	})
}

// / get all class
func GetAllClass(c *gin.Context) {
	var ClassTable []model.Class

	teacherId := c.Query("id")

	db := c.MustGet("db").(*gorm.DB)
	if teacherId == "" {
		if db.Find(&ClassTable).Error != nil {
			c.JSON(http.StatusBadGateway, model.MainModel{
				Status:  http.StatusBadGateway,
				Message: "Failed to get all class",
				Data:    nil,
			})
			return
		}
	} else {
		if db.Where("Advisor = ?", teacherId).Find(&ClassTable).Error != nil {
			c.JSON(http.StatusNotFound, model.MainModel{
				Status:  http.StatusNotFound,
				Message: "Teacher not found",
				Data:    nil,
			})
			return
		}
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    ClassTable,
	})
}

// / get all group on the class
func GetGroupClass(c *gin.Context) {
	var class model.Class
	var groupShow []model.GroupMember
	var classMemberGroup model.GroupClassMember

	id := c.PostForm("class_id")
	db := c.MustGet("db").(*gorm.DB)

	if db.Find(&model.Class{}).Where("class_id = ?", id).First(&class).Scan(&classMemberGroup).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Class not found",
			Data:    nil,
		})
		return
	}

	if db.Where("class_id = ?", id).Find(&model.Group{}).Scan(&groupShow).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to get group on the class",
			Data:    nil,
		})
		return
	}

	classMemberGroup.Groups = groupShow

	for i := 0; i < len(groupShow); i++ {
		db.Where("group_id = ?", groupShow[i].GroupID).Find(&model.Student{}).Scan(&groupShow[i].ListStudent)
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    classMemberGroup,
	})
}

// / get student on the class
func GetStudentClass(c *gin.Context) {
	var class model.Class
	var classMemberTable model.ClassMember
	var students []model.Student
	var studentShow []model.StudentShow

	id := c.Query("class_id")
	db := c.MustGet("db").(*gorm.DB)

	if db.Find(&model.Class{}).Where("class_id = ?", id).First(&class).Scan(&classMemberTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Class not found",
			Data:    nil,
		})
		return
	}

	if db.Where("class_id = ?", id).Find(&students).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to get student on the class",
			Data:    nil,
		})
		return
	}

	for i := 0; i < len(students); i++ {
		studentShow = append(studentShow, model.StudentShow{
			NIS:          students[i].NIS,
			Fullname:     students[i].Fullname,
			ImageProfile: students[i].ImageProfile,
			Contributes:  students[i].Contributes,
			Group: func() *model.GroupInitial {
				if students[i].GroupID != nil {
					group := &model.GroupInitial{}
					db.Where("group_id = ?", *students[i].GroupID).First(&model.Group{}).Scan(&group)
					return group
				} else {
					return nil
				}
			}(),
		})
	}

	classMemberTable.Students = studentShow

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    classMemberTable,
	})
}

// / change advisor on the class
func ChangeAdvisorClass(c *gin.Context) {
	var ClassTable model.Class
	var input model.ClassInput

	err := c.ShouldBindJSON(&input)
	if err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("nip = ?", input.Advisor).First(&model.Teacher{}).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    nil,
		})
		return
	}

	id := c.PostForm("class_id")
	if db.Where("class_id = ?", id).First(&ClassTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Class not found",
			Data:    nil,
		})
		return
	}

	if db.Model(&ClassTable).Update("advisor", input.Advisor).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to change advisor",
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
