package question_module

import (
	common "fuzzy/pkg/common/controller"
	model "fuzzy/pkg/common/model"
	"math"
	"math/rand"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

// add a new question
func AddQuestion(c *gin.Context) {
	var QuestionTable model.Question
	var input model.QuestionInput

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
	/// check if subject exist
	if db.Where("subject_id = ?", input.SubjectID).First(&model.Subject{}).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Subject not found",
			Data:    nil,
		})
		return
	}

	/// check if question exist
	if db.Where("question = ?", input.Question).First(&model.Question{}).Error == nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Question already exist",
			Data:    nil,
		})
		return
	}

	id := common.GenerateRandomID(30)
	QuestionTable = model.Question{
		QuestionID: id,
		SubjectID:  input.SubjectID,
		Question:   input.Question,
		Answer:     input.Answer,
		Option1:    input.Option1,
		Option2:    input.Option2,
		Option3:    input.Option3,
		Option4:    input.Option4,
		Poin:       input.Poin,
		Type:       input.Type,
		Tips:       input.Tips,
	}

	if db.Create(&QuestionTable).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to add new question",
			Data:    nil,
		})
		return
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    QuestionTable,
	})
}

// get all question by subject id
func AllQuestionSubject(c *gin.Context) {
	var QuestionTable []model.Question
	var input string

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

	/// check if subject exist
	if db.Where("subject_id = ?", input).First(&model.Subject{}).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Subject not found",
			Data:    nil,
		})
		return
	}

	db.Where("subject_id = ?", input).Find(&QuestionTable)

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    QuestionTable,
	})
}

// / update question by question_id
func UpdateQuestion(c *gin.Context) {
	var QuestionTable model.Question
	var input model.QuestionUpdate

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

	if db.Where("question_id = ?", input.QuestionID).First(&model.Question{}).Scan(&QuestionTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Question not found",
			Data:    nil,
		})
		return
	}

	if input.Question != nil {
		QuestionTable.Question = *input.Question
	}

	if input.Answer != nil {
		QuestionTable.Answer = *input.Answer
	}

	if input.Option1 != nil {
		QuestionTable.Option1 = *input.Option1
	}

	if input.Option2 != nil {
		QuestionTable.Option2 = *input.Option2
	}

	if input.Option3 != nil {
		QuestionTable.Option3 = *input.Option3
	}

	if input.Option4 != nil {
		QuestionTable.Option4 = *input.Option4
	}

	if input.Poin != nil {
		QuestionTable.Poin = (*input.Poin)
	}

	if input.Type != nil {
		QuestionTable.Type = *input.Type
	}

	if db.Model(&QuestionTable).Where("question_id = ?", input.QuestionID).Update(&QuestionTable).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to update question",
			Data:    nil,
		})
		return
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    QuestionTable,
	})
}

// / delete question by question_id
func DeleteQuestion(c *gin.Context) {
	var QuestionTable model.Question

	id := c.PostForm("question_id")

	db := c.MustGet("db").(*gorm.DB)

	if db.Where("question_id = ?", id).Delete(&QuestionTable).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to delete question",
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

// / get question by question_id
func GetQuestion(c *gin.Context) {
	var QuestionTable model.Question
	var input string

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

	if db.Where("question_id = ?", input).First(&QuestionTable).Error != nil {
		c.JSON(http.StatusNotFound, model.MainModel{
			Status:  http.StatusNotFound,
			Message: "Question not found",
			Data:    nil,
		})
		return
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    QuestionTable,
	})
}

// / get all question by SubjectWithQuestion model
func AllQuestion(c *gin.Context) {
	var questionTable []model.Question
	var questionShow []model.QuestionShow
	limit := c.Query("limit")
	page := c.Query("page")
	typeQuestion := c.Query("type_question")

	if page == "" {
		page = "1"
	}

	if limit == "" {
		limit = "10"
	}

	pageInt, err := strconv.Atoi(page)
	if err != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to get question",
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

	db := c.MustGet("db").(*gorm.DB)

	var offset int = (pageInt - 1) * limitInt

	db.Find(&questionTable).Count(&totalData)

	if typeQuestion != "" {
		db.Where("type = ?", typeQuestion).Order("RAND()").Limit(limitInt).Offset(offset).Find(&questionTable).Scan(&questionShow)
	} else {
		db.Order("RAND()").Limit(limitInt).Offset(offset).Find(&questionTable).Scan(&questionShow)
	}
	var totalPage int = int(math.Ceil(float64(totalData) / float64(limitInt)))

	c.JSON(http.StatusOK, model.MainModelPagination{
		Status:  http.StatusOK,
		Message: "Success",
		Pagination: &model.Pagination{
			TotalData: totalData,
			Page:      pageInt,
			TotalPage: totalPage,
		},
		Data: questionShow,
	})

}

func GetQuestionBySubject(c *gin.Context) {
	var questionTable []model.Question
	var questionShow []model.QuestionShow
	subjectId := c.Query("subject_id")
	limit := c.Query("limit")
	page := c.Query("page")
	typeQuestion := c.Query("type_question")

	if page == "" {
		page = "1"
	}

	if limit == "" {
		limit = "10"
	}

	pageInt, err := strconv.Atoi(page)
	if err != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to get question",
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

	if subjectId == "" {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Failed to get question",
			Data:    nil,
		})
		return
	}

	db := c.MustGet("db").(*gorm.DB)

	var offset int = (pageInt - 1) * limitInt

	if typeQuestion != "" {
		if db.Model(&model.Question{}).Where("subject_id = ? And type = ?", subjectId, typeQuestion).Count(&totalData).Limit(limitInt).Offset(offset).Find(&questionTable).Scan(&questionShow).Error != nil {
			c.JSON(http.StatusBadGateway, model.MainModel{
				Status:  http.StatusBadGateway,
				Message: "Failed to get question",
				Data:    nil,
			})
			return
		}
	} else {
		if db.Model(&model.Question{}).Where("subject_id = ?", subjectId).Count(&totalData).Limit(limitInt).Offset(offset).Find(&questionTable).Scan(&questionShow).Error != nil {
			print(err)
			c.JSON(http.StatusBadGateway, model.MainModel{
				Status:  http.StatusBadGateway,
				Message: "Failed to get question",
				Data:    nil,
			})
			return
		}
	}

	rand.Shuffle(len(questionShow), func(i, j int) {
		questionShow[i], questionShow[j] = questionShow[j], questionShow[i]
	})

	var totalPage int = int(math.Ceil(float64(totalData) / float64(limitInt)))

	c.JSON(http.StatusOK, model.MainModelPagination{
		Status:  http.StatusOK,
		Message: "Success",
		Pagination: &model.Pagination{
			TotalData: totalData,
			Page:      pageInt,
			TotalPage: totalPage,
		},
		Data: questionShow,
	})
}

func RemoveAllQuestion(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)
	db.Exec("DELETE FROM questions")
	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    nil,
	})
}
