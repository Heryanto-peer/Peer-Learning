package group_module

import (
	controller "fuzzy/pkg/common/controller"
	model "fuzzy/pkg/common/model"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func AddGroup(c *gin.Context) {
	var input []model.GroupInput
	var listGroup []model.Group

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
	for i := 0; i < len(input); i++ {

		// if db.Where("group_name = ?", input[i].GroupName).First(&model.Group{}).Error == nil {
		// 	c.JSON(http.StatusBadGateway, model.MainModel{
		// 		Status:  http.StatusBadGateway,
		// 		Message: "Group is already exist",
		// 		Data:    nil,
		// 	})
		// 	return
		// }
		
		if db.Where("class_id = ?", input[i].ClassID).First(&model.Class{}).Error != nil {
			c.JSON(http.StatusBadGateway, model.MainModel{
				Status:  http.StatusBadGateway,
				Message: "Class not found",
				Data:    nil,
			})
			return
		}
	}

	for i := 0; i < len(input); i++ {
		var groupTable model.Group
		id := controller.GenerateRandomID(30)
		groupTable = model.Group{
			GroupID:   id,
			GroupName: input[i].GroupName,
			ClassID:   input[i].ClassID,
		}

		if err := db.Create(&groupTable).Error; err != nil {
			c.JSON(http.StatusBadRequest, model.MainModel{
				Status:  http.StatusBadRequest,
				Message: err.Error(),
				Data:    nil,
			})
			return
		}
	}

	db.Where("class_id = ?", input[0].ClassID).Find(&model.Group{}).Scan(&listGroup)

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    listGroup,
	})
}

// get Group Members
func GetGroupMembers(c *gin.Context) {
	var group model.Group
	var groupMembers model.GroupMember

	db := c.MustGet("db").(*gorm.DB)
	if err := db.Where("group_id = ?", c.Query("group_id")).Find(&group).Scan(&groupMembers).Error; err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	if group.ClassID != "" {
		db.Where("class_id = ?", group.ClassID).Find(&model.Class{}).Scan(&groupMembers)
	}

	db.Where("group_id = ?", groupMembers.GroupID).Find(&model.Student{}).Scan(&groupMembers.ListStudent)

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    groupMembers,
	})
}

// / update Group
func UpdateGroupName(c *gin.Context) {
	var group model.Group
	name := c.PostForm("group_name")
	id := c.PostForm("group_id")

	db := c.MustGet("db").(*gorm.DB)
	if db.Where("group_id = ?", id).Find(&model.Group{}).First(&group).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Group not found",
			Data:    nil,
		})
		return
	}

	if err := db.Model(&model.Group{}).Where("group_id = ?", id).Update("group_name", name).Scan(&group).Error; err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}
	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    group,
	})
}

// / update Poin by group_id
func UpdateGroupPoin(c *gin.Context) {
	var group model.Group
	poin := c.PostForm("poin")
	id := c.PostForm("group_id")

	db := c.MustGet("db").(*gorm.DB)

	if db.Where("group_id = ?", id).Find(&model.Group{}).First(&group).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Group not found",
			Data:    nil,
		})
		return
	}
	grab, err := strconv.Atoi(poin)
	if err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Poin must be an integer",
			Data:    nil,
		})
		return
	}

	var total = 0
	if group.TotalPoin == nil {
		total = grab
	} else {
		total = (*group.TotalPoin) + grab
	}

	if err := db.Model(&model.Group{}).Where("group_id = ?", id).Update("total_poin", total).Scan(&group).Error; err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}
	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    group,
	})
}

// / delete group by group_id
func DeleteGroup(c *gin.Context) {
	var group model.Group
	var groupTable []model.Group
	id := c.PostForm("group_id")
	db := c.MustGet("db").(*gorm.DB)
	if db.Where("group_id = ?", id).Find(&model.Group{}).First(&group).Error != nil {
		c.JSON(http.StatusBadGateway, model.MainModel{
			Status:  http.StatusBadGateway,
			Message: "Group not found",
			Data:    nil,
		})
		return
	}

	if err := db.Where("group_id = ?", id).Delete(&model.Group{}).Error; err != nil {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: err.Error(),
			Data:    nil,
		})
		return
	}

	db.Find(&groupTable)
	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    groupTable,
	})
}

// / get all group
func AllGroup(c *gin.Context) {
	var groupTable []model.Group
	classId := c.Query("class_id")

	db := c.MustGet("db").(*gorm.DB)

	if classId != "" {
		db.Where("class_id = ?", classId).Find(&groupTable)
	} else {
		db.Find(&groupTable)
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    groupTable,
	})
}
