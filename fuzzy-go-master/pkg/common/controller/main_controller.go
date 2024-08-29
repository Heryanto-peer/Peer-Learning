package common_controller

import (
	model "fuzzy/pkg/common/model"
	"math/rand"

	"github.com/gin-gonic/gin"
)

func SetMainModel(pagination *model.Pagination, data interface{}) map[string]interface{} {
	mainModel := model.MainModel{
		Status:  200,
		Message: "Success",
		Data:    data,
	}
	return gin.H{"data": mainModel}
}

// / generate random id for student, teacher, subject, class, group
// / use rang 1-9 and a-z
// / example: 1a2b3c4d5e6f7g8h9i0j
func GenerateRandomID(length int) string {
	const letterBytes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	randBytes := make([]byte, length)

	for i := range randBytes {
		randBytes[i] = letterBytes[rand.Intn(len(letterBytes))]
	}
	return string(randBytes)

}

// / generate number random id with length 10
// / used algorithm shuffle from fisher yates
func GenerateRandomNumber(length int) string {
	const letterBytes = "0123456789"
	randBytes := make([]byte, length)
	for i := range randBytes {
		randBytes[i] = letterBytes[rand.Intn(len(letterBytes))]
	}
	return string(randBytes)
}
