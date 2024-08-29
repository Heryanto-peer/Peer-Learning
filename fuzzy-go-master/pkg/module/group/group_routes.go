package group_module

import "github.com/gin-gonic/gin"

func GroupRoutes(route *gin.Engine) {
	route.POST("/group/add", AddGroup)
	route.GET("/group/members", GetGroupMembers)
	route.PUT("/group/update/name", UpdateGroupName)
	route.PUT("group/update/poin", UpdateGroupPoin)
	route.DELETE("/group/remove", DeleteGroup)
	route.GET("/group/all", AllGroup)
}
