package assesment_module

import "github.com/gin-gonic/gin"

func AssesmentRoutes(route *gin.Engine) {
	route.GET("/assesment/get", GetAssesmentByNIS)
	route.POST("/assesment/update", UpdateAssesment)
}
