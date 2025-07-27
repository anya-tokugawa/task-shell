source "${TASK_SHELL_LIB}/obj/obj.bash"
declare -a taskIds
declare -a issueIds

_write_taskfile() {
  cat <(_generate_obj_payload) <(_generate_task_payload) > "$TASK_SHELL_DATA_DIR/task/$1"
}

_generate_task_payload() {
  cat <<- EOF
${info["PRIORITY"]},${info["DEADLINE_TIME"]},${info["SHOW_AS_TIME"]}${info["COMPLETE_TIME"]}
${info["LAST_DIARY_TIME"]},${info["LAST_STOCKTAKING_TIME"]}
$(_serialize_taskIds)
$(_serialize_issueIds)
EOF
}

_serialize_taskIds() {
  s=""
  for e in "${taskIds[@]}"; do s+="$e|";done
  echo -n "${s%?}"
}

_serialize_issueIds() {
  s=""
  for e in "${issueIds[@]}"; do s+="$e|";done
  echo -n "${s%?}"
}

_read_taskinfo() {
  _read_info # inheritance obj.sh and set variable 'info'
  # priority,deadline,showastime,completetime\n
  IFS=, read e1 e2 e3 e4 <<< "${_payload_lines[6]}"
  info["PRIORITY"]="$e1"
  info["DEADLINE_TIME"]="$e2"
  info["SHOW_AS_TIME"]="$e3"
  info["COMPLETE_TIME"]="$e4"
  # lastdiary,laststocktakingtime\n
  IFS=, read e1 e2 <<< "${_payload_lines[7]}"
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
_get_priority() { echo ${info["PRIORITY"]}; }
_get_deadlineTime() { echo ${info["DEADLINE_TIME"]}; }
_get_showAsTime() { echo ${info["SHOW_AS_TIME"]}; }
_get_completeTime() { echo ${info["COMPLETE_TIME"]}; }
_get_lastDiaryTime() { echo ${info["LAST_DIARY_TIME"]}; }
_get_lastStocktakingTime() { echo ${info["LAST_STOCKTAKING_TIME"]}; }

_read_child_taskIds() {
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
_del_entry_child_taskId() {
  if ! _is_exist_child_taskId "$1"; then
    echo "Err: no exist child taskId \"$1\""
    return false
  fi
  taskIds=("${taskIds[@]/$1/}")
  return true
}

_read_child_issueIds() {
  IFS="|" issueIds="${_payload_lines[9]}"
}
_is_exist_child_issueId() {
  for e in ${issueIds[@]}; do
    if [[ "$e" == "$1" ]]; then return true; fi
  done
  return false
}
_add_entry_child_issueId() {
  if _is_exist_child_issueId "$1"; then
    echo "Warn: alreadt set child issueId \"$1\""
    return false
  fi
  issueIds+=("$1")
  return true
}
_del_entry_child_issueId() {
  if ! _is_exist_child_issueId "$1"; then
    echo "Err: no exist child issueId \"$1\""
    return false
  fi
  issueIds=("${issueIds[@]/$1/}")
  return true
}
