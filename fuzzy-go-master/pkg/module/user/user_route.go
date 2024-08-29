package user_module

import "github.com/gin-gonic/gin"

func StudentRoutes(r *gin.Engine) {
	// login routes need form data nis (nomor induk siswa) and password
	r.POST("/student/login", StudentLogin)
	// register routes need raw json nis and fullname and password
	r.POST("/student/register", StudentRegister)
	// remove routes need form data nis
	r.DELETE("/student/remove", RemoveStudent)
	// update routes need raw json nis, password, image_profile, group_id, class_id (optional: group_id, class_id)
	r.PUT("/student/update", StudentUpdate)
	// update password routes need raw json nis, old_password, new_password (optional: group_id, class_id)
	r.PUT("/student/update/password", StudentUpdatePassword)
	// get all student
	r.GET("/student/all", GetStudent)
	// get student by name with path name
	r.GET("/student/name", GetStudent)
	// add student into class
	r.POST("/student/add/class", AddStudentToClass)
	// add student intp group
	r.POST("/student/add/group", AddStudentToGroup)
	// get detail student
	r.GET("/student/detail", GetStudentDetail)
	// collect poin
	r.POST("/student/collect-poin", CollectPoint)
	/// running worker
	r.GET("/student/worker-group", WorkerCountGroup)
	/// running fuzzy worker
	r.GET("/student/worker-fuzzy", FuzzyWorker)
}

func TeacherRoutes(r *gin.Engine) {
	// login routes need form data nip (nomor induk pengajar) and password
	r.POST("/teacher/login", TeacherLogin)
	// register routes need raw json nip and fullname and password and image_profile
	r.POST("/teacher/register", TeacherRegister)
	// remove routes need form data nip and code
	r.DELETE("/teacher/remove", RemoveTeacher)
	// update password routes need raw json nip, old_password, new_password
	r.PUT("/teacher/update/password", TeacherUpdatePassword)
	// update image profile need form data nip, password and image_profile
	r.PUT("/teacher/update/image", TeacherUpdateImage)
	// get all teacher
	r.GET("/teacher/all", AllTeacher)
}
