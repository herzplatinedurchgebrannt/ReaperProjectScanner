#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Reaper project file path missing."
  exit 1
fi

datei="$1"

regex='<([^ ]+) "([^:]+): ([^"]+)'

echo -e "Scan reaper project file: \n$datei"


regex='<([^ ]+) "([^:]+): ([^"]+)'

# dictionary
declare -A gefundene_plugins

while IFS= read -r zeile; do
  if [[ $zeile =~ $regex ]]; then
    plugin_format="${BASH_REMATCH[1]}"
    plugin_type="${BASH_REMATCH[2]}"
    plugin_name="${BASH_REMATCH[3]}"

    plugin_schluessel="${plugin_format}:${plugin_name}"

    if [[ -z "${gefundene_plugins[$plugin_schluessel]}" ]]; then
      echo -e "$plugin_format\t$plugin_type\t$plugin_name"
      gefundene_plugins[$plugin_schluessel]=1
    fi
  fi
done < "$datei"

