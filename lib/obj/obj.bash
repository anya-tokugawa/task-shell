declare -a _payload_lines
declare -A info
declare -A dependencySrc
declare -A dependencyDst
declare -A links
declare -a tags

_read_file() {
  mapfile -t _payload_lines < "$1"
  #declare -p _payload_lines #debug
}

_generate_obj_payload() {
  cat <<- EOF
${info["PARENT_TYPE"]},${info["PARENT_ID"]},${info["ID"]},${info["STATUS"]}
${info["NAME"]}
$(_serialize_dependencySrc)
$(_serialize_dependencyDst)
$(_serialize_links)
$(_serialize_tags)
EOF
}
#______________________ serialize
_serialize_dependencySrc() {
  s=""
  for k in "${!dependencySrc[@]}"; do
    v="$(_enc_str "${dependencySrc[$k]}")"
    s+="${k}|${v},"
  done
  echo -n "${s%?}"
}
_serialize_dependencyDst() {
  s=""
  for k in "${!dependencyDst[@]}"; do
    v="$(_enc_str "${dependencyDst[$k]}")"
    s+="${k}|${v},"
  done
  echo -n "${s%?}"
}
_serialize_links() {
  s=""
  for k in "${!links[@]}"; do
    v="$(_enc_str "${links[$k]}")"
    s="${s}${k}|${v},"
  done
  echo -n "${s%?}"
}

_serialize_tags() {
  s=""
  for e in "${tags[@]}"; do
    s="$(_enc_str "$e"),"
  done
  echo -n "${s%?}"
}
#____________________________________________

_read_all_variables() {
  _read_info
  _read_dependencySrc
  _read_dependencyDst
  _read_links
  _read_tags
}

_read_info() {
  IFS="," read -r parent_type parent_id obj_id status <<< "${_payload_lines[0]}"
  info["PARENT_TYPE"]="$parent_type"
  info["PARENT_ID"]="$parent_id"
  info["ID"]="$obj_id"
  info["STATUS"]="$status"
  info["NAME"]="${_payload_lines[1]}"
}
_set_parent_type() { info["PARENT_TYPE"]="$1"; }
_set_parent_id() { info["PARENT_ID"]="$1"; }
_set_id() { info["ID"]="$1"; }
_set_status() { info["STATUS"]="$1"; }
_set_name() { info["NAME"]="$1"; }

_get_parent_type() { echo ${info["PARENT_TYPE"]}; }
_get_parent_id() { echo ${info["PARENT_ID"]}; }
_get_id() { echo ${info["ID"]}; }
_get_status() { echo ${info["STATUS"]}; }
_get_name() { echo ${info["NAME"]}; }

_read_dependencySrc() {
  IFS=, a="${_payload_lines[2]}"
  for e in ${a[@]}; do
    IFS="|" read -r k v <<< "$e"
    d="$(_dec_str "$k")"
    dependencySrc[$d]="$v"
  done
}
_is_exist_in_dependencySrc() {
  for k in "${!dependencySrc[@]}"; do
    if [[ "$k" == "$1" ]]; then return true; fi
  done
  return false
}
_add_entry_dependencySrc() {
  if _is_exist_in_dependencySrc "$1"; then
    echo "Warn: already set variable in dependencySrc \"$1\"" >&2
    return false
  fi
  dependencySrc[$1]="$2"
  return true
}
_del_entry_dependencySrc() {
  if ! _is_exist_in_dependencySrc "$1"; then
    echo "Error: no exist variable in dependencySrc \"$1\"" >&2
    return false
  fi
  unset dependencySrc[$1]
  return true
}

_read_dependencyDst() {
  IFS=, a="${_payload_lines[3]}"
  for e in ${a[@]}; do
    IFS="|" read -r k v <<< "$e"
    d="$(_dec_str "$k")"
    dependencyDst[$d]="$v"
  done
  declare -p dependencyDst
}
_is_exist_in_dependencyDst() {
  for k in "${!dependencyDst[@]}"; do
    if [[ "$k" == "$1" ]]; then return true; fi
  done
  return false
}
_add_entry_dependencyDst() {
  if _is_exist_in_dependencyDst "$1"; then
    echo "Warn: already set variable in dependencyDst \"$1\"" >&2
    return false
  fi
  dependencyDst[$1]="$2"
  return true
}
_del_entry_dependencyDst() {
  if ! _is_exist_in_dependencyDst "$1"; then
    echo "Error: no exist variable in dependencyDst \"$1\"" >&2
    return false
  fi
  unset dependencyDst[$1]
  return true
}

_read_links() {
  IFS=, a="${_payload_lines[4]}"
  for e in ${a[@]}; do
    IFS="|" read -r k v <<< "$e"
    d="$(_dec_str "$k")"
    links[$d]="$v"
  done
}
_is_exist_in_links() {
  for k in "${!links[@]}"; do
    if [[ "$k" == "$1" ]]; then return true; fi
  done
  return false
}
_add_entry_links() {
  if _is_exist_in_links "$1"; then
    echo "Warn: already set variable in links \"$1\"" >&2
    return false
  fi
  links[$1]="$2"
  return true
}

_del_entry_links() {
  if ! _is_exist_in_links "$1"; then
    echo "Error: no exist variable in links \"$1\"" >&2
    return false
  fi
  unset links[$1]
  return true
}

_read_tags() {
  IFS=, a="${_payload_lines[5]}"
  for e in ${a[@]}; do
    tags+=("$(_dec_str "$e")")
  done
}
