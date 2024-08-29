package user_module

import (
	"encoding/json"
	"fmt"
	model "fuzzy/pkg/common/model"
	fuzzifikasi "fuzzy/pkg/module/fuzzyfikasi"
	"math"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func FuzzyWorker(c *gin.Context) {
	classID := c.Query("class_id")

	// crtTime := c.Query("times")

	db := c.MustGet("db").(*gorm.DB)

	// if crtTime == "" {
	loc, _ := time.LoadLocation("Asia/Jakarta")
	var crtTime = time.Now().In(loc).Format("2006-01-02")
	// }

	var group []model.Group

	if classID == "" {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Class ID not found",
			Data:    nil,
		})
		return
	}

	db.Where("class_id = ?", classID).Find(&group)

	for _, g := range group {
		var members []model.Student
		var assesments []model.Assesment
		if db.Where("group_id = ? AND class_id = ?", g.GroupID, classID).Find(&[]model.Student{}).Scan(&members).Error != nil {
			fmt.Println("Error: ", "group members not found skip group %s", g.GroupName)
			continue
		}

		if db.Where("group_id = ? AND date_created = ?", g.GroupID, crtTime).Find(&[]model.Assesment{}).Scan(&assesments).Error != nil {
			fmt.Println("Error: ", "Assesment not found on this group %s", g.GroupID)
			continue
		}

		for _, m := range members {
			var historyPoin model.PoinHistory
			var myPoin model.PoinQuiz
			var keaktifan = 0
			var resultKeaktifan = 0
			var kontribusi = 0
			var resultKontribusi = 0
			var lengthGroup = len(members)

			if db.Where("nis = ? AND group_id = ? AND date_created = ?", m.NIS, g.GroupID, crtTime).Find(&[]model.PoinHistory{}).First(&model.PoinHistory{}).Scan(&historyPoin).Error != nil {
				fmt.Println("Error: ", "Poin History not found skip member %s", m.Fullname)
				continue
			}
			json.Unmarshal([]byte(historyPoin.PoinQuiz), &myPoin)

			for _, a := range assesments {
				if a.NIS == m.NIS {
					continue
				}
				var assesment []model.PoinAssesment
				json.Unmarshal([]byte(a.Assesments), &assesment)

				for _, ass := range assesment {
					if ass.NIS == m.NIS {
						keaktifan += *ass.Significant
						kontribusi += *ass.Helpful
					}
				}
			}
			if lengthGroup < 4 {
				resultKeaktifan = keaktifan
				resultKontribusi = kontribusi
			} else {
				pembagi := 3.0 / 4.0
				resultKeaktifan = keaktifan / int(math.Round(pembagi))
				resultKontribusi = kontribusi / int(math.Round(pembagi))
			}

			fuzzy := fuzzifikasi.MainFuzzy(myPoin.PreQuizPoin, myPoin.PostQuizPoin, resultKeaktifan, resultKontribusi)
			myPoin.FuzzyPoin = fuzzy
			*m.Contributes += float64(myPoin.FuzzyPoin)
			stringMyPoin, _ := json.Marshal(myPoin)

			if db.Model(&model.PoinHistory{}).Where("nis = ? AND group_id = ? AND date_created = ?", m.NIS, g.GroupID, crtTime).Update("poin_quiz", stringMyPoin).Error != nil {
				fmt.Println("Error: ", "Poin History not found skip member %s", m.Fullname)
				continue
			}

			if db.Model(m).Where("nis = ? AND group_id = ?", m.NIS, g.GroupID).Update("contributes", m.Contributes).Error != nil {
				fmt.Println("Error: ", "Poin Student not found skip member %s", m.Fullname)
				continue
			}

			fmt.Println("Success: ", "Fuzzy Worker %d, total %d", m.Fullname, myPoin.FuzzyPoin)
		}
	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    nil,
	})

}

func WorkerCountGroup(c *gin.Context) {

	db := c.MustGet("db").(*gorm.DB)
	classID := c.Query("class_id")
	var crtTime = time.Now().Format("2006-01-02")
	var group []model.Group

	if classID == "" {
		c.JSON(http.StatusBadRequest, model.MainModel{
			Status:  http.StatusBadRequest,
			Message: "Class ID not found",
			Data:    nil,
		})
		return
	}

	db.Where("class_id = ?", classID).Find(&group)

	for _, g := range group {

		var memberPoint []model.PoinHistory
		db.Where("group_id = ? AND date_created = ?", g.GroupID, crtTime).Find(&memberPoint)
		var allDaily int = 0
		var dailyUser int = 0
		var allPost int = 0
		var postUser int = 0
		var allPre int = 0
		var preUser int = 0

		for _, v := range memberPoint {
			var poin model.PoinQuiz
			json.Unmarshal([]byte(v.PoinQuiz), &poin)
			if poin.DailyQuizPoin > 0 {
				dailyUser++
			}

			if poin.PostQuizPoin > 0 {
				postUser++
			}

			if poin.PreQuizPoin > 0 {
				preUser++
			}

			allDaily += poin.DailyQuizPoin
			allPost += poin.PostQuizPoin
			allPre += poin.PreQuizPoin
		}

		var defaultValue = 0
		if g.TotalPoin == nil {
			g.TotalPoin = &defaultValue
		}
		var groupPoinDaily = 0

		if dailyUser != 0 {
			var medianDaily = allDaily / dailyUser
			groupPoinDaily = medianDaily
		}

		var groupPoinPost = 0

		if postUser != 0 {
			var medianPost = allPost / postUser
			groupPoinPost = medianPost
		}
		var groupPoinPre = 0

		if preUser != 0 {
			var medianPre = allPre / preUser
			groupPoinPre = medianPre
		}

		var sum = groupPoinDaily + groupPoinPost + groupPoinPre + +*g.TotalPoin

		db.Model(&model.Group{}).Where("group_id = ? AND class_id = ?", g.GroupID, classID).Update("total_poin", sum)

	}

	c.JSON(http.StatusOK, model.MainModel{
		Status:  http.StatusOK,
		Message: "Success",
		Data:    nil,
	})

}
