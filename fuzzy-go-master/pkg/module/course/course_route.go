package course_module

import (
	"github.com/gin-gonic/gin"
)

func CourseRoutes(router *gin.Engine) {
	router.POST("/course/add", addCourseSubject)
	router.DELETE("/course/remove", removeCourseSubject)
	router.GET("/course", getCourseSubject)
}
