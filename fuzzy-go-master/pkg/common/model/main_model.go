package common_model

type MainModelPagination struct {
	Status     int         `json:"status"`
	Message    string      `json:"message"`
	Pagination *Pagination `json:"pagination"`
	Data       interface{} `json:"data"`
}

type MainModel struct {
	Status  int         `json:"status"`
	Message string      `json:"message"`
	Data    interface{} `json:"data"`
}

type Pagination struct {
	Page      int `json:"page"`
	TotalPage int `json:"total_page"`
	TotalData int `json:"total_data"`
}
