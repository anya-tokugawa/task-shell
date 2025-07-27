source "${TASK_SHELL_LIB}/obj/obj.bash"
declare -a taskIds
declare -p issueIds

_write_taskfile() {
  cat <(_generate_obj_payload) <(_generate_prj_payload) > "$1"
}

_generate_prj_payload() {
  cat <<- EOF
  ${info["PRIORITY"]},${info["DEADLINE_TIME"]},${info["SHOW_AS_TIME"]}${info["COMPLETE_TIME"]}
  ${info["LAST_DIARY_TIME"]},${info["LAST_STOCKTAKING_TIME"]}
  $(_serialize_taskIds)
  $(_serialize_prjIds)
EOF
}

_serialize_taskIds() {
  s=""
  for e in "${taskIds[@]}"; do s+="$e|";done
  echo -n "${s%?}"
}

_serialize_prjIds() {
  s=""
  for e in "${prjIds[@]}"; do s+="$e|";done
  echo -n "${s%?}"
}

_read_prjinfo(){
  _getinfo # inheritance obj.sh and set variable 'info'
  IFS=, e1 e2 e3 e4 <<< "${_payload_lines[6]}"
  info["PRIORITY"]="$e1"
  info["DEADLINE_TIME"]="$e1"
  info["SHOW_AS_TIME"]="$e1"
  info["COMPLETE_TIME"]="$e1"
  IFS=, e1 e2 <<< "${_payload_lines[7]}"
  info["LAST_DIARY_TIME"]="$e1"
  info["LAST_STOCKTAKING_TIME"]="$e2"
}
# set
_set_priority() { info["PRIORITY"]="$1"; }
_set_deadlineTime() { info["DEADLINE_TIME"]="$1"; }
_set_showAsTime() { info["SHOW_AS_TIME"]="$1"; }
_set_completeTime() { info["COMPLETE_TIME"]="$1"; }
_set_lastDiaryTime() { info["LAST_DIARY_TIME"]="$1"; }
_set_lastStocktakingTime() { info["LAST_STOCKTAKING_TIME"]="$1"; }
# get
_get_priority() { echo ${["PRIORITY"]}; }
_get_deadlineTime() { echo ${["DEADLINE_TIME"]}; }
_get_showAsTime() { echo ${["SHOW_AS_TIME"]}; }
_get_completeTime() { echo ${["COMPLETE_TIME"]}; }
_get_lastDiaryTime() { echo ${["LAST_DIARY_TIME"]}; }
_get_lastStocktakingTime() { echo ${["LAST_STOCKTAKING_TIME"]}; }

_read_child_taskIds(){
  IFS="|" taskids="${_payload_lines[8]}"
}
_is_exist_child_taskId() {
  for e in ${taskIds[@]}; do
    if [[ "$e" == "$1" ]]; then return true; fi
  done
  return false
}
_add_entry_child_taskId() {
  if _is_exist_child_taskId "$1"; then
    echo "Warn: alreadt set child taskId \"$1\""
    return false
  fi
  taskIds+=("$1")
  return true
}

_read_child_prjIds(){
  IFS="|" prjIds="${_payload_lines[9]}"
}

_is_exist_child_prjId() {
  for e in ${prjIds[@]}; do
    if [[ "$e" == "$1" ]]; then return true; fi
  done
  return false
}
_add_entry_child_prjId() {
  if _is_exist_child_prjId "$1"; then
    echo "Warn: alreadt set child prjId \"$1\""
    return false
  fi
  prjIds+=("$1")
  return true
}
_del_entry_child_prjId() {
  if ! _is_exist_child_prjId "$1"; then
    echo "Err: no exist child prjId \"$1\""
    return false
  fi
  prjIds=("${prjIds[@]/$1/}")
  return true
}
