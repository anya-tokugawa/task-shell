#!/bin/bash -eu
# @file Task
# @brief doing, implementing it honesty
# @description

SUB_CMD_TYPE="FUNC"
SUB_CMD_LIST["ls"]="ListTask"
SUB_CMD_LIST["add"]="AddTask"
SUB_CMD_LIST["prj"]="CallPrj"
SUB_CMD_LIST["job"]="CallJob"

AddTask(){
  source "${TASK_SHELL_LIB}/obj/task.bash"
  id="$(uuidgen)"
  _set_parent_type "root"
  _set_parent_id "-"
  _set_id "$id"
  _set_status "enable"
  _set_name "$1"
  _set_priority "0"
  _set_deadlineTime "$(date -d '+1day 23:59:59' +'%s')"
  _set_showAsTime "$(date -d 'now' +'%s')"
  _set_completeTime "0"
  _set_lastDiaryTime "0"
  _set_lastStocktakingTime "0"
  _write_taskfile "$id"
}

ListTask(){
  source "${TASK_SHELL_LIB}/obj/task.bash"
  (
    echo "* Now: $(date -d 'now' +'%Y-%m-%d %H:%M:%S')"
    echo -e "id\tname\tstatus\tDeadline"
    while read f;do
      _read_file "$f"
      _read_taskinfo
      id=$(_get_id)
      echo -e "${id%%-*}\t$(_get_name)\t$(_get_status)\t$(date -d "@$(_get_deadlineTime)" +'%Y-%m-%d %H:%M' )"
    done < <(find "$TASK_SHELL_DATA_DIR/task/" -type f)
  ) | column -t -s$'\t'
}
