package themes

import (
	"github.com/aubm/postmanerator/postman"
)

func helperFindFirstResponse(req postman.Request) *postman.Response {
	for index, res := range req.Responses {
		if index == 0 {
			return &res
		}
	}
	return nil
}
