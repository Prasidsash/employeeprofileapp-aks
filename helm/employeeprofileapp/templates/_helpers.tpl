{{/*
=====================================
FILE: helm/employeeprofileapp/templates/_helpers.tpl
VERSION: v4-enterprise-disposable-final
=====================================
*/}}

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

{{/*
=====================================
WORKLOAD IDENTITY LABELS
=====================================
*/}}

{{- define "employeeprofileapp.workloadIdentityLabels" -}}

azure.workload.identity/use: "true"

{{- end }}

{{/*
=====================================
WORKLOAD IDENTITY ANNOTATIONS
=====================================
*/}}

{{- define "employeeprofileapp.workloadIdentityAnnotations" -}}

{{- if .Values.workloadIdentity.enabled }}

azure.workload.identity/use: "true"

{{- if .Values.workloadIdentity.clientId }}

azure.workload.identity/client-id: {{ .Values.workloadIdentity.clientId | quote }}

{{- end }}

{{- if .Values.workloadIdentity.tenantId }}

azure.workload.identity/tenant-id: {{ .Values.workloadIdentity.tenantId | quote }}

{{- end }}

{{- end }}

{{- end }}

{{/*
=====================================
STANDARD SECURITY CONTEXT
=====================================
*/}}

{{- define "employeeprofileapp.securityContext" -}}

allowPrivilegeEscalation: false

runAsNonRoot: true

readOnlyRootFilesystem: false

capabilities:

  drop:

    - ALL

{{- end }}

{{/*
=====================================
STANDARD POD LABELS
=====================================
*/}}

{{- define "employeeprofileapp.podLabels" -}}

app: {{ include "employeeprofileapp.name" . }}

{{- if .Values.workloadIdentity.enabled }}

azure.workload.identity/use: "true"

{{- end }}

{{- end }}