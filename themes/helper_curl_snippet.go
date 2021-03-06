package themes

import (
	"fmt"
	"regexp"
	"strings"

	"github.com/aubm/postmanerator/postman"
)

func curlSnippet(request postman.Request) string {
	var curlSnippet string

	payloadReady, _ := regexp.Compile("POST|PUT|PATCH|DELETE")

	//added to accomendate postman setup
	host := strings.Split(request.URL, "/")[0]
	host = parseHost(host)
	getPathOnly := strings.Replace(request.URL, "{"+host+"}", "", 1)

	curlSnippet += fmt.Sprintf("curl -X %v", request.Method)
	curlSnippet += fmt.Sprintf(` "https://%v"`, host+getPathOnly)
	curlSnippet += fmt.Sprintf(" \\")

	if payloadReady.MatchString(request.Method) {
		//not needed as included in postman
		// if request.PayloadType == "urlencoded" {
		// 	curlSnippet += ` -H "Content-Type: application/x-www-form-urlencoded"`
		// } else
		if request.PayloadType == "params" {
			curlSnippet += ` --header "Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW"`
		}
	}

	for _, header := range request.Headers {
		curlSnippet += fmt.Sprintf("\n")
		curlSnippet += fmt.Sprintf(`--header "%v: %v"`, header.Name, header.Value)
		curlSnippet += fmt.Sprintf(" \\")
	}

	if payloadReady.MatchString(request.Method) {
		curlSnippet += fmt.Sprintf("\n")
		if request.PayloadType == "raw" && request.PayloadRaw != "" {
			curlSnippet += fmt.Sprintf(`--data-raw '%v'`, request.PayloadRaw)
			curlSnippet += fmt.Sprintf(" \\")
		} else if len(request.PayloadParams) > 0 {
			if request.PayloadType == "urlencoded" {
				//var dataList []string
				for _, data := range request.PayloadParams {
					curlSnippet += fmt.Sprintf(`--data-urlencode "%v=%v"`, data.Key, data.Value)
					curlSnippet += fmt.Sprintf(" \\")
					curlSnippet += fmt.Sprintf("\n")
					//curlSnippet = strings.TrimRight(curlSnippet, " \\")
					//dataList = append(dataList, fmt.Sprintf("%v=%v", data.Key, data.Value))
				}
				//curlSnippet += fmt.Sprintf(`--data-urlencode "%v"`, dataList)
			} else if request.PayloadType == "params" {
				for _, data := range request.PayloadParams {
					curlSnippet += fmt.Sprintf(`-F "%v=%v"`, data.Key, data.Value)
					curlSnippet += fmt.Sprintf(" \\")
					curlSnippet += fmt.Sprintf("\n")
				}
			}
		}
	}

	curlSnippet = strings.TrimRight(curlSnippet, " \\")
	return curlSnippet
}

func parseHost(host string) string {
	host = strings.Replace(host, "{", "", 1)
	host = strings.Replace(host, "}", "", 1)

	return host
}
