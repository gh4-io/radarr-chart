{{/*
Translate .Value.configmap to deployment volumes.
*/}}
{{- define "prowlarr.volumeConfigMap" -}}
  {{- if .Values.configMap }}
    {{- if .Values.configMap.existingConfigMap}}
      {{- range $key, $value := .Values.configMap.existingConfigMap }}
      {{- range $ckey, $cvalue := $value }}
- _type: configMap
  configMap:
    name: {{ $ckey }}
  name: {{ $cvalue.mntName }}
      {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}


{{/*
tanslate .Value.configMap to Init Pod
*/}}
{{- define "prowlarr.initConfigMap" -}}
  {{- if .Values.configMap }}
    {{- if .Values.configMap.existingConfigMap}}
      {{- range $key, $value := .Values.configMap.existingConfigMap }}
      {{- range $ckey, $cvalue := $value }}
      {{- if eq ( $cvalue.pod | default "primary" ) "init" }}
- name: {{ $cvalue.mntName }}
  mountPath: {{ $cvalue.path }}
  subPath: {{ $cvalue.subPath }}
  readOnly: true
      {{- end }}
      {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
tanslate .Value.configMap to Primary Pod
*/}}
{{- define "prowlarr.primaryConfigMap" -}}
  {{- if .Values.configMap }}
    {{- if .Values.configMap.existingConfigMap}}
      {{- range $key, $value := .Values.configMap.existingConfigMap }}
      {{- range $ckey, $cvalue := $value }}
      {{- if eq ( $cvalue.pod | default "primary" ) "primary" }}
- name: {{ $cvalue.mntName }}
  mountPath: {{ $cvalue.path }}
  subPath: {{ $cvalue.subPath | default nil }}
  readOnly: true
      {{- end }}
      {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}


{{/*
 {{- $type := ("init" "primary") }}
 {{- if has "init" $type }}
 */}}
