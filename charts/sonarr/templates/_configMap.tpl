{{/*
Translate .Value.configmap to deployment volumes.
*/}}
{{- define "sonarr.volumeConfigMap" -}}
  {{- if .Values.configMap }}
    {{- if .Values.configMap.existingConfigMap}}
      {{- range $key, $value := .Values.configMap.existingConfigMap }}
- _type: configMap
  configMap:
    name: {{ $key }}
  name: {{ $value.mntName }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}


{{/*
tanslate .Value.configMap to Init Pod
*/}}
{{- define "sonarr.initConfigMap" -}}
  {{- if .Values.configMap }}
    {{- if .Values.configMap.existingConfigMap}}
      {{- range $key, $value := .Values.configMap.existingConfigMap }}
      {{- if eq ( $value.pod | default "primary" ) "init" }}
- name: {{ $value.mntName }}
  mountPath: {{ $value.path }}
  subPath: {{ $value.subPath }}
  readOnly: true
      {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
tanslate .Value.configMap to Primary Pod
*/}}
{{- define "sonarr.primaryConfigMap" -}}
  {{- if .Values.configMap }}
    {{- if .Values.configMap.existingConfigMap}}
      {{- range $key, $value := .Values.configMap.existingConfigMap }}
      {{- if eq ( $value.pod | default "primary" ) "primary" }}
- name: {{ $value.mntName }}
  mountPath: {{ $value.path }}
  subPath: {{ $value.subPath | default nil }}
  readOnly: true
      {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}


{{/*
 {{- $type := ("init" "primary") }}
 {{- if has "init" $type }}
 */}}
