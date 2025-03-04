#!/bin/bash -eu
# @file Task
# @brief doing, implementing it honesty
# @description

TASK_SHELL_TASKDIR="${TASK_SHELL_TASKDIR:-/var/task-shell/task.d}"
SUB_CMD_TYPE="FUNC"
SUB_CMD_LIST["ls"]="ListTask"
SUB_CMD_LIST["prj"]="CallPrj"
SUB_CMD_LIST["job"]="CallJob"
