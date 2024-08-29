package subject_module

import (
	"github.com/gin-gonic/gin"
)

func SubjectRoutes(router *gin.Engine) {
	/// add new subject
	router.POST("/subject/add", AddSubject)

	/// remove subject by subject_id (form data)
	router.DELETE("/subject/remove", RemoveSubject)

	/// update subject by subject_id (json data) need param subject_id and nip
	router.PUT("/subject/update-nip", UpdateSubject)

	/// get subject by nip (form data)
	router.GET("/subject", GetSubjectByNIP)

	/// get all subject
	router.GET("/subject/all", GetAllSubject)

	/// add materi into subject
	router.POST("/subject/add/materi", AddMateri)

	/// remove materi from subject
	router.DELETE("/subject/remove/materi", RemoveMateri)

	/// getSubject by subject_id
	router.GET("/subject/detail", getSubjectById)
}
