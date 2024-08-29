package class_module

import "github.com/gin-gonic/gin"

func ClassRoutes(route *gin.Engine) {
	// add new class
	route.POST("/class/add", AddClass)
	route.GET("/class/dvisor", ChangeAdvisorClass)
	route.GET("/class/students", GetStudentClass)
	route.GET("/class/all", GetAllClass)
	route.GET("/class/groups", GetGroupClass)
}
