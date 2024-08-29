package common_routes

import (
	"context"
	assesment "fuzzy/pkg/module/assesment"
	class "fuzzy/pkg/module/class"
	course "fuzzy/pkg/module/course"
	group "fuzzy/pkg/module/group"
	question "fuzzy/pkg/module/question"
	subjetc "fuzzy/pkg/module/subject"
	user "fuzzy/pkg/module/user"

	config "fuzzy/pkg/common/utils"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	ginadapter "github.com/awslabs/aws-lambda-go-api-proxy/gin"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

var ginLambda *ginadapter.GinLambda

func SetupRoutes(db *gorm.DB) {
	var envrontment = config.GetEnvVar("ENV")
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()
	r.Use(func(c *gin.Context) {
		c.Set("db", db)
	})

	config := cors.DefaultConfig()
	config.AllowHeaders = []string{"Origin", "Content-Length", "Content-Type", "X-Requested-With", "Accept"}
	config.AllowMethods = []string{"POST", "GET", "PUT", "OPTIONS", "DELETE"}
	config.AllowAllOrigins = true
	// config.AllowOrigins = []string{"https://fuzzy-app-1a834.web.app/", "http://localhost:8080", "http://localhost:5000", "http://grandrealty.luru.space", "https://grandrealty.luru.space"}
	config.AllowCredentials = true

	r.Use(cors.New(config))
	r.Static("/files", "./assets")

	user.StudentRoutes(r)
	user.TeacherRoutes(r)
	subjetc.SubjectRoutes(r)
	question.QuestionRoutes(r)
	class.ClassRoutes(r)
	group.GroupRoutes(r)
	course.CourseRoutes(r)
	assesment.AssesmentRoutes(r)

	if envrontment == "Prod-AWS" {
		ginLambda = ginadapter.New(r)
		lambda.Start(HandlerRequest)
	} else if envrontment == "Dev" {
		r.Run(":8080")
	} else {
		r.Run()
	}
}

func HandlerRequest(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return ginLambda.ProxyWithContext(ctx, req)
}
