COLLECTION

Name: {{ .Name }}
Description: {{ .Description }}

REQUESTS
{{ range .Requests }}
------------
ID={{ .ID }}
Name={{ .Name }}
Description={{ .Description }}
Method={{ .Method }}
URL={{ .URL }}
PayloadType={{ .PayloadType }}
PayloadRaw={{ .PayloadRaw }}
PayloadParams
{{ range .PayloadParams }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
PathVariables
{{ range .PathVariables }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
QueryParams
{{ range .QueryParams }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
Headers
{{ range .Headers }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
RESPONSES
{{ range .Responses }}
************
ID={{ .ID }}
Name={{ .Name }}
Status={{ .Status }}
StatusCode={{ .StatusCode }}
Body={{ .Body }}
PayloadRaw={{ .PayloadRaw }}
Headers
{{ range .Headers }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
{{ end }}
{{ end }}

FOLDERS
{{ range .Folders }}
$$$$$$$$$$$$
ID={{ .ID }}
Name={{ .Name }}
Description={{ .Description }}
REQUESTS
{{ range .Requests }}
------------
ID={{ .ID }}
Name={{ .Name }}
Description={{ .Description }}
Method={{ .Method }}
URL={{ .URL }}
PayloadType={{ .PayloadType }}
PayloadRaw={{ .PayloadRaw }}
PayloadParams
{{ range .PayloadParams }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
PathVariables
{{ range .PathVariables }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
QueryParams
{{ range .QueryParams }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
Headers
{{ range .Headers }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
RESPONSES
{{ range .Responses }}
************
ID={{ .ID }}
Name={{ .Name }}
Status={{ .Status }}
StatusCode={{ .StatusCode }}
Body={{ .Body }}
PayloadRaw={{ .PayloadRaw }}
Headers
{{ range .Headers }}
Name={{ .Name }}
Key={{ .Key }}
Value={{ .Value }}
Description={{ .Description }}
{{ end }}
{{ end }}
{{ end }}
{{ end }}

STRUCTURES
{{ range .Structures }}
------------
Name={{ .Name }}
Description={{ .Description }}
Fields
{{ range .Fields }}
************
Name={{ .Name }}
Description={{ .Description }}
Type={{ .Type }}
CharacterLength={{ .CharacterLength }}
{{ end }}
{{ end }}