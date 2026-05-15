{{/*
Expand the chart name.
*/}}

{{- define "employeeprofileapp.name" -}}
{{- default .Chart.Name .Values.app.name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}

{{- define "employeeprofileapp.fullname" -}}
{{- default .Chart.Name .Values.app.name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Chart label.
*/}}

{{- define "employeeprofileapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end }}

{{/*
Common labels.
*/}}

{{- define "employeeprofileapp.labels" -}}
helm.sh/chart: {{ include "employeeprofileapp.chart" . }}

app.kubernetes.io/name: {{ include "employeeprofileapp.name" . }}

app.kubernetes.io/instance: {{ .Release.Name }}

app.kubernetes.io/version: {{ .Chart.AppVersion }}

app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}

{{- define "employeeprofileapp.selectorLabels" -}}
app: {{ include "employeeprofileapp.name" . }}
{{- end }}