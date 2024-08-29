package course_module

import (
	model "fuzzy/pkg/common/model"
	assesment "fuzzy/pkg/module/assesment"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func addCourseSubject(c *gin.Context) {
	var courseTable model.SubjectCourse

	id := c.PostForm("subject_id")
	class := c.PostForm("class_id")
	start := c.PostForm("start_course")
	end := c.PostForm("end_course")
	db := c.MustGet("db").(*gorm.DB)

	if db.Where("class_id = ?", class).Find(&model.Class{}).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Class not found",
			Data:    nil,
		})
		return
	}

	if class != "" {
		courseTable.ClassID = &class
	} else {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Missing parameter",
			Data:    nil,
		})
	}

	if db.Where("subject_id = ?", id).Find(&model.Subject{}).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Subject not found",
			Data:    nil,
		})
		return
	}

	if id != "" {
		courseTable.SubjectID = &id
	} else {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Missing parameter",
			Data:    nil,
		})
	}

	if start != "" {
		courseTable.StartCourse = &start
	} else {
		courseTable.StartCourse = nil
	}

	if end != "" {
		courseTable.EndCourse = &end
	} else {
		courseTable.EndCourse = nil
	}

	/// check group on the class
	var groups []model.Group
	db.Where("class_id = ?", class).Find(&model.Group{}).Scan(&groups)
	if len(groups) == 0 {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "No group on the class",
			Data:    nil,
		})
		return
	}

	/// memasukkan data assesment ke semua siswa dari kelas
	var preparing = true
	for _, group := range groups {
		var student []model.Student
		if db.Where("group_id = ? And class_id = ?", group.GroupID, group.ClassID).Find(&model.Student{}).Scan(&student).Error != nil {
			c.JSON(http.StatusBadRequest, model.MainModel{
				Status:  http.StatusBadRequest,
				Message: "Failed to add course",
				Data:    nil,
			})
			return
		}

		for _, s := range student {
			var assesmentInput = model.AssesmentInput{
				NIS:       s.NIS,
				GroupID:   group.GroupID,
				SubjectID: *courseTable.SubjectID,
			}

			success, err := assesment.NewDataAssesment(assesmentInput, c, db)

			if !success || err != nil {
				preparing = false
				c.JSON(http.StatusBadRequest, model.MainModel{
					Status:  http.StatusBadRequest,
					Message: "Failed to add course",
					Data:    nil,
				})
				break
			}
		}
	}

	if !preparing {
		dA := assesment.RemoveDataAssesment(*courseTable.SubjectID, c)
		if dA {
			c.JSON(http.StatusBadRequest, model.MainModel{
				Status:  http.StatusBadRequest,
				Message: "Failed to add course",
				Data:    nil,
			})
			return
		}
	}

	db.Where("class_id = ?", class).Find(&model.SubjectCourse{}).Delete(&model.SubjectCourse{})
	if db.Save(&courseTable).Error != nil {
		assesment.RemoveDataAssesment(*courseTable.SubjectID, c)
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Failed to add course",
			Data:    nil,
		})
		return
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    courseTable,
	})
}

func getCourseSubject(c *gin.Context) {
	var courseTable model.SubjectCourse
	class := c.Query("class_id")
	if class == "" {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Missing parameter",
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("class_id = ?", class).Find(&model.SubjectCourse{}).First(&courseTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Course not found",
			Data:    nil,
		})
		return
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    courseTable,
	})
}

func removeCourseSubject(c *gin.Context) {
	class := c.Query("class_id")
	if class == "" {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Missing parameter",
			Data:    nil,
		})
		return
	}
	db := c.MustGet("db").(*gorm.DB)

	if db.Where("class_id = ?", class).Find(&model.SubjectCourse{}).Delete(&model.SubjectCourse{}).Error != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Failed to remove course",
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
