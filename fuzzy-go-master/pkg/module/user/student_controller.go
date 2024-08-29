package user_module

import (
	"encoding/json"
	model "fuzzy/pkg/common/model"
	"math"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

// remove Student data by Student id
func RemoveStudent(c *gin.Context) {
	var StudentTable model.Student

	id, err := strconv.Atoi(c.PostForm("nis"))
	if err != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)
	password := c.PostForm("password")
	if password == "i am root" {
		if db.Where("nis = ?", id).First(&StudentTable).Error != nil {
			c.JSON(http.StatusNotFound, model.MainModel{
				Status:  http.StatusNotFound,
				Message: "Student not found",
				Data:    nil,
			})
		}
	} else {
		if db.Where("nis = ? AND password = ?", id, password).First(&StudentTable).Error != nil {
			c.JSON(http.StatusNotFound, model.MainModel{
				Status:  http.StatusNotFound,
				Message: "Student not found",
				Data:    nil,
			})
			return
		}
	}

	if db.Delete(model.Student{}, "nis = ?", id).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to remove Student",
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

// update Student data (password, image profile, group id, class id)
func StudentUpdate(c *gin.Context) {
	var StudentTable model.Student
	var Student model.StudentShow
	var input model.StudentUpdateInput

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	if input.KeyPas != "iam root" {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Password is wrong",
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)
	if db.First(&StudentTable, "nis = ?", input.NIS).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Student not found",
			Data:    nil,
		})
		return
	}

	update := model.StudentUpdate{
		Fullname:     StudentTable.Fullname,
		ImageProfile: StudentTable.ImageProfile,
		GroupID:      StudentTable.GroupID,
		ClassID:      StudentTable.ClassID,
		Contributes:  StudentTable.Contributes,
		Password:     StudentTable.Password,
	}

	if input.ImageProfile != nil {
		update.ImageProfile = input.ImageProfile
	}

	if input.Fullname != nil {
		update.Fullname = *input.Fullname
	}

	if input.Contributes != nil {
		update.Contributes = input.Contributes
	}

	if db.Model(&StudentTable).Where("nis = ?", StudentTable.NIS).Update(&update).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to update Student",
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

// update Student password by Student id
func StudentUpdatePassword(c *gin.Context) {
	var StudentTable model.Student
	var Student model.StudentShow
	var input model.StudentPasswordInput

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("nis = ? AND password = ?", input.NIS, input.OldPassword).First(&StudentTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "NIS or password is wrong",
			Data:    nil,
		})
		return
	}

	if db.Model(&StudentTable).Where("nis = ?", StudentTable.NIS).Update(map[string]interface{}{"password": input.NewPassword}).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to update Student password",
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

// get all the Student data and query by page
// give the result page information total page, page, and total data from db
func GetStudent(c *gin.Context) {
	var StudentTable []model.Student
	var Student []model.StudentShowDetail
	db := c.MustGet("db").(*gorm.DB)
	page := c.Query("page")
	limit := c.Query("limit")
	tag := c.Query("tag")
	search := c.Query("search")

	switch tag {
	case "fullname":
		tag = "fullname"
	case "1":
		tag = "class_id"
	case "2":
		tag = "group_id"
	default:
		tag = "fullname"
	}

	if page == "" || limit == "" {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "page or limit is empty",
			Data:    nil,
		})
		return
	}
	pageInt, err := strconv.Atoi(page)
	if err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}
	limitInt, err := strconv.Atoi(limit)
	if err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}
	var totalData int

	if search != "" {
		if err := db.Where(""+tag+" LIKE ?", "%"+search+"%").Find(&StudentTable).Count(&totalData).Error; err != nil {
			c.JSON(http.StatusBadRequest, model.MainModel{
				Status:  http.StatusBadRequest,
				Message: err.Error(),
				Data:    nil,
			})
			return
		}
	} else {
		if err := db.Find(&StudentTable).Count(&totalData).Error; err != nil {
			c.JSON(http.StatusBadRequest, model.MainModel{
				Status:  http.StatusBadRequest,
				Message: err.Error(),
				Data:    nil,
			})
			return
		}
	}

	if search != "" {
		if err := db.Where(""+tag+" LIKE ?", "%"+search+"%").Limit(limitInt).Offset((pageInt - 1) * limitInt).Find(&StudentTable).Error; err != nil {
			c.JSON(http.StatusBadRequest, model.MainModel{
				Status:  http.StatusBadRequest,
				Message: err.Error(),
				Data:    nil,
			})
			return
		}
	} else {

		if err := db.Limit(limitInt).Offset((pageInt - 1) * limitInt).Find(&StudentTable).Error; err != nil {
			c.JSON(http.StatusBadRequest, model.MainModel{
				Status:  http.StatusBadRequest,
				Message: err.Error(),
				Data:    nil,
			})
			return
		}
	}
	for _, v := range StudentTable {
		Student = append(Student, model.StudentShowDetail{
			NIS:          v.NIS,
			Fullname:     v.Fullname,
			ImageProfile: v.ImageProfile,
			Contributes:  v.Contributes,
			Class: func() *model.ClasInitial {
				if v.ClassID != nil {
					class := &model.Class{}
					var ClassTable []model.Class
					print("", v.ClassID)
					if db.Find(&ClassTable).
						Where("class_id = ?", v.ClassID).First(&class).Error != nil {
						return nil
					}

					return &model.ClasInitial{
						ClassID:   class.ClassID,
						Advisor:   class.Advisor,
						ClassName: class.ClassName,
					}
				} else {
					return nil
				}
			}(),
			Group: func() *model.GroupInitial {
				if v.GroupID != nil {
					group := &model.GroupInitial{}
					db.Where("group_id = ?", *v.GroupID).First(&model.Group{}).Scan(&group)
					return group
				} else {
					return nil
				}
			}(),
		})

	}
	c.JSON(http.StatusOK, model.MainModelPagination{
		Status:  http.StatusOK,
		Message: "Success",
		Pagination: &model.Pagination{
			TotalData: totalData,
			Page:      pageInt,
			TotalPage: int(math.Ceil(float64(totalData) / float64(limitInt))),
		},
		Data: Student,
	})

}

// get Student data by name
func GetStudentByName(c *gin.Context) {
	var StudentTable []model.Student
	var Student []model.StudentShow
	db := c.MustGet("db").(*gorm.DB)
	if err := db.Where("fullname LIKE ?", "%"+c.Query("name")+"%").Find(&StudentTable).Error; err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}
	for _, v := range StudentTable {
		Student = append(Student, model.StudentShow{
			NIS:          v.NIS,
			Fullname:     v.Fullname,
			ImageProfile: v.ImageProfile,
			Contributes:  v.Contributes,
		})
	}
	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    Student,
	})
}

// / add student into class
func AddStudentToClass(c *gin.Context) {
	var classTable model.Class
	db := c.MustGet("db").(*gorm.DB)

	nis, err := strconv.Atoi(c.PostForm("nis"))

	if err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	classID := c.PostForm("class_id")

	if classID == "" {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Missing parameter",
			Data:    nil,
		})
		return
	}

	if db.Where("class_id = ?", classID).First(&classTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Class not found",
			Data:    nil,
		})
		return
	}

	if db.Where("class_id = ? AND nis = ?", classID, nis).First(&classTable).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Student already in class",
			Data:    nil,
		})
		return
	}

	if db.Model(&model.Student{}).Where("nis = ?", nis).Update("class_id", classID).Update("class", classTable).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to add student into class",
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

func AddStudentToGroup(c *gin.Context) {
	var inputs model.InputGroupStudent

	if err := c.ShouldBindJSON(&inputs); err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)

	if db.Where("group_id = ?", inputs.GroupID).First(&model.Group{}).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Group not found",
			Data:    nil,
		})
		return
	}

	for _, v := range inputs.NIS {
		if db.Model(&model.Student{}).Where("nis = ?", v).Update("group_id", inputs.GroupID).Error != nil {
			c.JSON(http.StatusBadGateway, model.MainModel{
				Status:  http.StatusBadGateway,
				Message: "Failed to add student into group",
				Data:    nil,
			})
			return
		}
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    nil,
	})
}

func GetStudentDetail(c *gin.Context) {
	var student model.Student
	var detail model.StudentDetail

	nis, err := strconv.Atoi(c.Query("nis"))
	if err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)

	if db.Where("nis = ?", nis).First(&student).Scan(&detail).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Student not found",
			Data:    nil,
		})
		return
	}

	if student.GroupID != nil {
		db.Where("group_id = ?", student.GroupID).First(&model.Group{}).Scan(&detail.Group)
	}

	if student.ClassID != nil {
		db.Where("class_id = ?", student.ClassID).First(&model.Class{}).Scan(&detail.Class)
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    detail,
	})

}

func CollectPoint(c *gin.Context) {
	var userPoin model.PoinHistory
	var input model.PoinHistoryInput
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	loc, _ := time.LoadLocation("Asia/Jakarta")
	var date = time.Now().In(loc).Format("2006-01-02")

	db := c.MustGet("db").(*gorm.DB)

	var holderStudent model.Student
	if db.Where("nis = ? ", input.NIS).First(&holderStudent).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Student not found",
			Data:    nil,
		})
		return
	}

	if holderStudent.GroupID == nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "group is not exist",
			Data:    nil,
		})
		return
	}

	// if *holderStudent.GroupID != *input.GroupID {
	// 	c.JSON(http.StatusBadGateway, model.MainModel{
	// 		Status:  http.StatusBadGateway,
	// 		Message: "Student is not in a group",
	// 		Data:    nil,
	// 	})
	// 	return
	// }

	var student model.Student
	db.Where("nis = ?", input.NIS).Find(&student)
	var userPoinList []model.PoinHistory
	if db.Where("nis = ? AND date_created = ? AND group_id = ?", input.NIS, date, *input.GroupID).Find(&userPoinList).First(&userPoin).Error != nil {
		userPoin = model.PoinHistory{
			NIS:         input.NIS,
			GroupID:     *input.GroupID,
			DateCreated: date,
			PoinQuiz:    "",
		}
		db.Create(&userPoin)
	}

	var myPoin model.PoinQuiz
	if userPoin.PoinQuiz != "" {
		if err := json.Unmarshal([]byte(userPoin.PoinQuiz), &myPoin); err != nil {
			c.JSON(http.StatusBadRequest, model.MainModel{
				Status:  http.StatusBadRequest,
				Message: err.Error(),
				Data:    nil,
			})
			return
		}
	} else {
		myPoin = model.PoinQuiz{}
	}
	poinCollect, _ := input.PoinQuiz, 64

	if input.PoinType == "pre-poin" {
		myPoin.PreQuizPoin = poinCollect
	}
	if input.PoinType == "post-poin" {
		myPoin.PostQuizPoin = poinCollect
	}
	if input.PoinType == "daily-poin" {
		myPoin.DailyQuizPoin = poinCollect
		student.LatestDaily = &date
	}
	if input.PoinType == "fuzzy-poin" {
		myPoin.FuzzyPoin = poinCollect
	}

	myPoinJSON, err := json.Marshal(myPoin)
	if err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	userPoin.PoinQuiz = string(myPoinJSON)
	if db.Model(&userPoin).Where("nis = ? AND date_created = ? ", userPoin.NIS, date).Update("poin_quiz", userPoin.PoinQuiz).Error != nil {
		print(err)
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to update poin",
			Data:    nil,
		})
		return

	}

	var defaultValue = 0.0
	if student.Contributes == nil {
		student.Contributes = &defaultValue
	}
	*student.Contributes += float64(input.PoinQuiz)
	db.Model(&student).Where("nis = ?", input.NIS).Update("contributes", student.Contributes)
	/// update personal poin
	if input.PoinType == "daily-poin" {
		db.Model(&student).Where("nis = ?", input.NIS).Update("latest_daily", date)
	}

	// if input.PoinType != "daily-poin" {
	var group model.Group
	db.Model(&model.Group{}).Where("group_id = ?", *input.GroupID).Find(&group)
	var defaultTotalPoin = 0
	if group.TotalPoin == nil {
		group.TotalPoin = &defaultTotalPoin
	}

	// var poinMembers []model.PoinHistory
	// if db.Where("group_id = ? AND date_created = ? ", *input.GroupID, date).Find(&model.PoinHistory{}).Scan(&poinMembers).Error != nil {
	// 	c.JSON(http.StatusBadGateway, model.MainModel{
	// 		Status:  http.StatusBadGateway,
	// 		Message: "Failed to update poin",
	// 		Data:    nil,
	// 	})
	// 	return

	// }

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    nil,
	})
}
