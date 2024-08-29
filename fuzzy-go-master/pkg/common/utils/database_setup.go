package utils

import (
	"fmt"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

func SetupDBProd() *gorm.DB {
	User := GetEnvVar("USER_DB_PROD")
	PASS := GetEnvVar("PASS_DB_PROD")
	HOST := GetEnvVar("HOST_DB_PROD")
	DBNAME := GetEnvVar("NAME_DB_PROD")
	OPT := "endpoint%3Dep-rough-forest-a189ukct"
	URL := fmt.Sprintf("host=%s user=%s password=%s dbname=%s sslmode=require options=%s", HOST, User, PASS, DBNAME, OPT)
	// connStr := "postgres://koyeb-adm:3XUSKBu5OrcQ@ep-rough-forest-a189ukct.ap-southeast-1.pg.koyeb.app/koyebdb?sslmode=require&options=endpoint%3Dep-rough-forest-a189ukct
	// URL := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=5432 sslmode=disable TimeZone=Asia/Jakarta", HOST, User, PASS, DBNAME)
	// dsn := url.URL{
	// 	User:     url.UserPassword(User, PASS),
	// 	Scheme:   "postgres",
	// 	Host:     HOST,
	// 	Path:     DBNAME,
	// 	RawQuery: (&url.Values{"sslmode": []string{"disable"}}).Encode(),
	// }

	db, err := gorm.Open("postgres", URL)

	// db, err := gorm.Open("postgres", dsn.String())
	// db, err := gorm.Open(postgres.Open(URL), &gorm.Config{})
	if err != nil {
		panic(err.Error())
	}
	return db
}

func SetupDBDev() *gorm.DB {
	Student := GetEnvVar("USER_DB_DEV")
	PASS := GetEnvVar("PASS_DB_DEV")
	HOST := GetEnvVar("HOST_DB_DEV")
	PORT := GetEnvVar("PORT_DB_DEV")
	DBNAME := GetEnvVar("NAME_DB_DEV")

	URL := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local", Student, PASS, HOST, PORT, DBNAME)
	db, err := gorm.Open("mysql", URL)
	if err != nil {
		fmt.Println("Error: ", err)
	}
	return db
}

func SetupDBStag() *gorm.DB {
	Student := GetEnvVar("USER_DB_STAG")
	PASS := GetEnvVar("PASS_DB_STAG")
	HOST := GetEnvVar("HOST_DB_STAG")
	PORT := GetEnvVar("PORT_DB_STAG")
	DBNAME := GetEnvVar("NAME_DB_STAG")
	// Student := os.Getenv("MYSQL_USER")    //GetEnvVar("USER_DB_DEV")
	// PASS := os.Getenv("MYSQL_PASSWORD")   //GetEnvVar("PASS_DB_DEV")
	// HOST := os.Getenv("MYSQL_HOST")       //GetEnvVar("HOST_DB_DEV")
	// PORT := "3306"                        //GetEnvVar("PORT_DB_DEV")
	// DBNAME := os.Getenv("MYSQL_DATABASE") //GetEnvVar("NAME_DB_DEV")

	URL := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local", Student, PASS, HOST, PORT, DBNAME)
	db, err := gorm.Open("mysql", URL)
	if err != nil {
		fmt.Println("Error: ", err)
	}
	return db
}
