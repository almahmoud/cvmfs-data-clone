{{/*
Get unique name for extra files
*/}}
{{- define "galaxy.getExtraFilesUniqueName" -}}
{{- (printf "%s" (include "galaxy.makeDnsCompliant" (printf "extra-%s-%s" (include "galaxy.getFilenameFromPath" .) (. | sha256sum))))  }}
{{- end -}}


{{/*
Extract the filename portion from a file path
*/}}
{{- define "galaxy.getFilenameFromPath" -}}
{{- printf "%s" (. | splitList "/" | last) -}}
{{- end -}}


{{/*
Make string DNS-compliant by turning to lowercase then removing all noncompliant characters
*/}}
{{- define "galaxy.makeDnsCompliant" -}}
{{- (printf "%s" (regexReplaceAll "[^a-z0-9-]" (. | lower) "")) | trunc 63 | trimSuffix "-"  }}
{{- end -}}

