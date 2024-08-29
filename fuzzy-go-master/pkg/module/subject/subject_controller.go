package subject_module

import (
	"encoding/json"
	"fmt"
	common "fuzzy/pkg/common/controller"
	model "fuzzy/pkg/common/model"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

// add new subject
func AddSubject(c *gin.Context) {
	var SubjectTable model.Subject
	var input model.SubjectInput

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
	if db.Where("nip = ?", input.NIP).First(&model.Teacher{}).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    nil,
		})
		return
	}

	/// check if subject exist
	if db.Where("subject_name = ?", input.SubjectName).First(&model.Subject{}).Error == nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Subject already exist",
			Data:    nil,
		})
		return
	}

	id := common.GenerateRandomID(30)
	SubjectTable = model.Subject{
		SubjectID:    id,
		SubjectName:  input.SubjectName,
		NIP:          input.NIP,
		SubjectLevel: input.SubjectLevel,
	}

	if db.Create(&SubjectTable).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to add new subject",
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

// remove subject by subject_id
func RemoveSubject(c *gin.Context) {
	var SubjectTable model.Subject

	id := c.PostForm("subject_id")
	db := c.MustGet("db").(*gorm.DB)
	if db.Where("subject_id = ?", id).First(&SubjectTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Subject not found",
			Data:    nil,
		})
		return
	}

	if db.Delete(model.Subject{}, "subject_id = ?", id).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to remove subject",
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

// update NIP by subject_id
func UpdateSubject(c *gin.Context) {
	var SubjectTable model.Subject
	var input model.SubjectUpdateTeacher

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
	if db.Where("subject_id = ?", input.SubjectID).First(&SubjectTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Subject not found",
			Data:    nil,
		})
		return
	}

	if db.Where("nip = ?", input.NewNIP).First(&model.Teacher{}).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    nil,
		})
		return
	}

	if db.Model(&SubjectTable).Update(map[string]interface{}{"nip": input.NewNIP}).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to update subject",
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

// / get subject by nip
func GetSubjectByNIP(c *gin.Context) {
	var subject []model.SubjectShow
	var teacherTable model.Teacher

	nip := c.PostForm("nip")

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("nip = ?", nip).First(&teacherTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Teacher not found",
			Data:    nil,
		})
		return
	}

	db.Table("subjects").Select("subjects.subject_id, subjects.subject_name, subjects.subject_level, teachers.fullname as teacher_name").Joins("left join teachers on subjects.nip = teachers.nip").Where("subjects.nip = ?", nip).Scan(&subject)

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    subject,
	})
}

// / get all subject
func GetAllSubject(c *gin.Context) {
	var subject []model.SubjectShow
	var holder []model.SubjectShowHolder

	var guru = c.Query("id")

	db := c.MustGet("db").(*gorm.DB)
	if guru != "" {

		db.Table("subjects").Select("subjects.subject_id, subjects.subject_name, subjects.subject_level, teachers.fullname as teacher_name, subjects.subject_materi").Joins("left join teachers on subjects.nip = teachers.nip").Where("teachers.nip = ?", guru).Scan(&holder)
	} else {
		db.Table("subjects").Select("subjects.subject_id, subjects.subject_name, subjects.subject_level, teachers.fullname as teacher_name, subjects.subject_materi").Joins("left join teachers on subjects.nip = teachers.nip").Scan(&holder)
	}

	for i := 0; i < len(holder); i++ {
		subject = append(subject, model.SubjectShow{
			SubjectID:    holder[i].SubjectID,
			SubjectName:  holder[i].SubjectName,
			SubjectLevel: holder[i].SubjectLevel,
			TeacherName:  holder[i].TeacherName,
		})
	}

	for i := 0; i < len(holder); i++ {
		if holder[i].SubjectMateri != nil {
			json.Unmarshal([]byte(*holder[i].SubjectMateri), &subject[i].SubjectMateri)
		}
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    subject,
	})
}

// add materi into subject
func AddMateri(c *gin.Context) {
	var subjectTable model.Subject
	var listMateri = []model.SubjectMateri{}

	file, err := c.FormFile("subject_materi")
	if err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	if c.Request.ContentLength > 5000000 {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "File too large (>1MB)",
			Data:    nil,
		})
		return
	}

	if filepath.Ext(file.Filename) != ".pdf" {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "File must be pdf",
			Data:    nil,
		})
		return
	}

	id := c.PostForm("subject_id")
	name := c.PostForm("materi_name")

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("subject_id = ?", id).First(&subjectTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Subject not found",
			Data:    nil,
		})
		return
	}
	id = common.GenerateRandomNumber(10)
	nameFile := strings.ReplaceAll(name, " ", "-")
	dst := filepath.Join("assets", ""+id+"-"+nameFile+filepath.Ext(file.Filename))

	if err := c.SaveUploadedFile(file, dst); err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	url := fmt.Sprintf("%s/files/%s", c.Request.Host, id+"-"+nameFile+filepath.Ext(file.Filename))

	if subjectTable.SubjectMateri != nil {
		json.Unmarshal([]byte(*subjectTable.SubjectMateri), &listMateri)
		if len(listMateri) > 0 {
			listMateri = append([]model.SubjectMateri{listMateri[0]}, listMateri...)
		} else {
			listMateri = append(listMateri, model.SubjectMateri{})
		}

		listMateri[0] = model.SubjectMateri{
			MateriID:   id,
			PathMateri: url,
			MateriName: name,
		}

	} else {
		listMateri = append(listMateri, model.SubjectMateri{
			MateriID:   id,
			PathMateri: url,
			MateriName: name,
		})
	}

	jsonMateri, _ := json.Marshal(listMateri)

	if db.Model(&subjectTable).Where("subject_id = ?", subjectTable.SubjectID).Update(map[string]interface{}{"subject_materi": jsonMateri}).Error != nil {
		os.Remove(dst)
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to update subject",
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

// / remove materi from subject
func RemoveMateri(c *gin.Context) {
	var subjectTable model.Subject
	var listMateri = []model.SubjectMateri{}

	subjectID := c.PostForm("subject_id")
	materiID := c.PostForm("materi_id")

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("subject_id = ?", subjectID).First(&subjectTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Subject not found",
			Data:    nil,
		})
		return
	}

	if subjectTable.SubjectMateri != nil {
		json.Unmarshal([]byte(*subjectTable.SubjectMateri), &listMateri)
		for i := 0; i < len(listMateri); i++ {
			if listMateri[i].MateriID == materiID {
				pathName := strings.Split(listMateri[i].PathMateri, "/")[len(strings.Split(listMateri[i].PathMateri, "/"))-1]
				target := filepath.Join("assets", pathName)
				os.Remove(target)
				listMateri = append(listMateri[:i], listMateri[i+1:]...)

				break
			}
		}
	}

	jsonMateri, _ := json.Marshal(listMateri)

	if db.Model(&subjectTable).Where("subject_id = ?", subjectTable.SubjectID).Update(map[string]interface{}{"subject_materi": jsonMateri}).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to update subject",
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

// / get subject with list of materi by subject_id
func GetSubjectMateri(c *gin.Context) {
	var subjectTable model.Subject
	var subjectMateriTable []model.SubjectMateri

	subjectID := c.PostForm("subject_id")

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("subject_id = ?", subjectID).First(&subjectTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Subject not found",
			Data:    nil,
		})
		return
	}

	db.Table("subject_materis").Select("subject_materis.materi_id, subject_materis.materi_name, subject_materis.path_materi").Where("subject_materis.subject_id = ?", subjectID).Scan(&subjectMateriTable)

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    subjectMateriTable,
	})

}

func getSubjectById(c *gin.Context) {
	var subject model.SubjectShow
	var holder model.SubjectShowHolder

	db := c.MustGet("db").(*gorm.DB)
	db.Table("subjects").Select("subjects.subject_id, subjects.subject_name, subjects.subject_level, teachers.fullname as teacher_name, subjects.subject_materi").Joins("left join teachers on subjects.nip = teachers.nip").Where("subjects.subject_id = ?", c.Query("subject_id")).Scan(&holder)

	subject = model.SubjectShow{
		SubjectID:    holder.SubjectID,
		SubjectName:  holder.SubjectName,
		SubjectLevel: holder.SubjectLevel,
		TeacherName:  holder.TeacherName,
	}

	if holder.SubjectMateri != nil {
		json.Unmarshal([]byte(*holder.SubjectMateri), &subject.SubjectMateri)
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    subject,
	})
}
