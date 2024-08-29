package question_module

import (
	"github.com/gin-gonic/gin"
)

func QuestionRoutes(router *gin.Engine) {
	/// add new question to the database
	router.POST("/question/add", AddQuestion)
	router.DELETE("/question/remove", DeleteQuestion)
	router.PUT("/question/update", UpdateQuestion)
	router.GET("/question", GetQuestion)
	router.GET("/question/all", AllQuestion)
	router.GET("/question/subject/all", AllQuestionSubject)
	router.GET("/question/subject", GetQuestionBySubject)
	router.DELETE("/question/removeall", RemoveAllQuestion)
}
