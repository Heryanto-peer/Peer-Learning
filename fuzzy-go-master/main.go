package main

import (
	models "fuzzy/pkg/common/model"
	routes "fuzzy/pkg/common/routes"
	config "fuzzy/pkg/common/utils"

	"github.com/jinzhu/gorm"
)

func main() {
	var envrontment = config.GetEnvVar("ENV")
	var db *gorm.DB
	if envrontment == "Prod" {
		db = config.SetupDBProd()
	} else if envrontment == "Stag" {
		db = config.SetupDBStag()
	} else {
		db = config.SetupDBDev()
	}

	db.AutoMigrate(&models.Student{})
	db.AutoMigrate(&models.Teacher{})
	db.AutoMigrate(&models.Subject{})
	db.AutoMigrate(&models.Class{})
	db.AutoMigrate(&models.Group{})
	db.AutoMigrate(&models.Question{})
	db.AutoMigrate(&models.SubjectCourse{})
	db.AutoMigrate(&models.PoinHistory{})
	db.AutoMigrate(&models.Assesment{})

	routes.SetupRoutes(db)

}
