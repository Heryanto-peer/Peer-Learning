package assesment_module

import (
	"encoding/json"
	"fmt"
	controller "fuzzy/pkg/common/controller"
	model "fuzzy/pkg/common/model"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func GetAssesmentByNIS(c *gin.Context) {
	nis := c.Query("nis")
	var assesment model.Assesment
	var assesmentShow model.AssesmentShow

	db := c.MustGet("db").(*gorm.DB)
	var listAssesassesment = []model.Assesment{}
	if db.Model(&model.Assesment{}).Where("nis = ?", nis).Find(&listAssesassesment).First(&model.Assesment{}).Scan(&assesment).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Assesment not found",
			Data:    nil,
		})
		return
	}

	assesmentShow = model.AssesmentShow{
		AssesmentID: assesment.AssesmentID,
		NIS:         assesment.NIS,
		DATECREATED: assesment.DATECREATED,
	}

	if assesment.Assesments != "" {
		err := json.Unmarshal([]byte(assesment.Assesments), &assesmentShow.Assesments)
		if err != nil {
			fmt.Println(err)
		}
	}

	if assesment.GroupID != "" {
		var group model.Group
		db.Model(&model.Group{}).Where("group_id = ?", assesment.GroupID).Find(&group)
		assesmentShow.GroupName = group.GroupName
	}

	if assesment.SubjectID != "" {
		var subject model.Subject
		db.Model(&model.Subject{}).Where("subject_id = ?", assesment.SubjectID).Find(&subject)
		assesmentShow.SubjectName = subject.SubjectName
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    assesmentShow,
	})

}

func RemoveDataAssesment(subjectID string, c *gin.Context) bool {

	loc, _ := time.LoadLocation("Asia/Jakarta")
	var time = time.Now().In(loc).Format("2006-01-02")
	db := c.MustGet("db").(*gorm.DB)
	success := db.Where("subject_id = ? And date_created = ?", subjectID, time).Delete(&model.Assesment{}).Error != nil

	return success
}

func addPoinAssesment(student []model.Student, except int) []model.PoinAssesment {
	var poinAssesment []model.PoinAssesment
	var defaultValue = 0
	for i := 0; i < len(student); i++ {
		if student[i].NIS == except {
			continue
		}
		assesment := model.PoinAssesment{
			NIS:         student[i].NIS,
			Fullname:    student[i].Fullname,
			Significant: &defaultValue,
			Helpful:     &defaultValue,
		}

		poinAssesment = append(poinAssesment, assesment)

	}

	return poinAssesment
}

func NewDataAssesment(input model.AssesmentInput, c *gin.Context, db *gorm.DB) (bool, error) {
	var student []model.Student
	if db.Where("group_id = ?", input.GroupID).Find(&student).Error != nil {
		return false, db.Error
	}

	var newAssesment = addPoinAssesment(student, input.NIS)
	var id = controller.GenerateRandomID(5)
	var stringAssesment, err = json.Marshal(newAssesment)

	loc, _ := time.LoadLocation("Asia/Jakarta")
	var crntTime = time.Now().In(loc).Format("2006-01-02")
	if err != nil {
		return false, err
	}
	var table = model.Assesment{
		NIS:         input.NIS,
		GroupID:     input.GroupID,
		SubjectID:   input.SubjectID,
		AssesmentID: id,
		Assesments:  string(stringAssesment),
		DATECREATED: crntTime,
	}

	var exist []model.Assesment
	if db.Where("nis = ? AND group_id = ? AND subject_id = ? AND date_created = ?", input.NIS, input.GroupID, input.SubjectID, crntTime).Find(&exist).Error == nil {
		if len(exist) != 0 {
			db.Where("nis = ? AND group_id = ? AND subject_id = ? AND date_created = ?", input.NIS, input.GroupID, input.SubjectID, crntTime).Delete(&model.Assesment{})
		}
	}

	if db.Create(&table).Error != nil {
		return false, db.Error
	}
	return true, nil
}

func UpdateAssesment(c *gin.Context) {
	var table model.Assesment
	var input model.AssesmentUpdate

	errInput := c.ShouldBindJSON(&input)
	if errInput != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: errInput.Error(),
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)

	if db.Where("assesment_id = ?", input.AssesmentID).First(&table).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Assesment not found",
			Data:    nil,
		})
		return
	}
	stringAssesment, _ := json.Marshal(input.Assesments)

	table.Assesments = string(stringAssesment)
	if db.Model(&table).Where("assesment_id = ?", input.AssesmentID).Update("assesments", table.Assesments).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "failed to update assesment",
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
