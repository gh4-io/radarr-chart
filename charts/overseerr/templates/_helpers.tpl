{{/*
Expand the name of the chart.
*/}}
{{- define "overseerr.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "overseerr.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "overseerr.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "overseerr.labels" -}}
helm.sh/chart: {{ include "overseerr.chart" . }}
app.kubernetes.io/app: {{ printf "%s" .Chart.Annotations.app | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "overseerr.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: servarr
{{- end }}

{{/*
Selector labels
*/}}
{{- define "overseerr.selectorLabels" -}}
app.kubernetes.io/name: {{ include "overseerr.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "overseerr.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "overseerr.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "overseerr.volumeName" -}}
{{- .Values.persistence.volumeName | default ( printf "%s-%s-pv" ( .Release.Namespace ) ( include "overseerr.fullname" . ))  }}
{{- end }}

{{- define "overseerr.volumePath" -}}
{{- .Values.persistence.volumePath | default "/var/snap/microk8s/common/default-storage/" }}
{{- end }}

{{- define "overseerr.pvName" -}}
{{ printf "%s-%s-pv" .Release.Namespace ( include "overseerr.fullname" . ) }}
{{- end }}

{{- define "overseerr.pvcName" -}}
{{ default (printf "%s-pvc" ( include "overseerr.fullname" . )) .Values.persistence.existingClaim }}
{{- end }}