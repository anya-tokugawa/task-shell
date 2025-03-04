# task-shell commands design

```bash
usage: tsksh [OPTIONS] [subcmds...] [args...]
```

## 2 mode

- shell-mode
- commands-mode

## general rule

- 'task in task' can for hirarchial tasks.
- 'prj in prj' can for big project
- certainty, 'task in prj' is ok.
- 'prj in task' may link to other project's tasks, but  project should independence because need to human resource strucure, goal setting, etc.

some way have dependency task isn't limited tree-strcutured, linked task.
so, tshsk possible to imagine 'task in way(sub task grouping for complete task) of task' or 'task in (a single) task'.

job is root of task grouping. task and way is only do something. but, job is required judgement or arrive at goal.

| Word | meaning |
|------|---------|
|task|doing, implementing it honesty |
|prj |project, need to human resource srtructure, goal setting, etc |
|job |job have a goal, or require judgement. job need to materials(sub task, sub way, sub job).|
|way |way have order for step-by-step. way have tasks(waypoint).
|issue|issue is object of preventing Goal, having some detailed/specific problem. issue link to task/job/way |



| Recursive Rule | Support | Meaning |
|----------------|---------|---------|
| task in task   | OK | a task is child or depend a single other task |
| task in way    | OK | a task is a waypoint in parent task |
| way in task    | OK | a task can have way for solve issue |
| issue in task  | OK | a task can have issue for closing task |
| prj in prj     | OK | a prj is child in big project, or sub prj set other smaller goal |
| prj in task    | NG | project should independence becuz need to human resource srtructure, goal setting, etc |
| prj link task  | OK | alternative: if a task need to depend other prj |

```
root
 |
 +-- task: motley tasks
 |
 +-- job
 |    |
 |    +-- task
 |
 +-- prj: mainly project, manage dependency child task, job. manage priority job and task.
      |
      +-- prj: sub project, folder
      |
      +-- task: motley task in project
      +-- task
      |
      +-- job
      +-- job: need judgement, or complete multple task
           |
           +-- task
```

```
task: manage priority task, way. manage issue.
 |
 +-- task: simple dependency subtasks
 +-- task
 |
 +-- way: task flow, step by step, order.
 |    |
 |    +-- 1. task
 |    +-- 2. task
 |
 +-- issue
```


## shell-mode

```
tsksh
 |
 +--> task: ls, cd, add, del
 +--> prj: ls, add, del, select [prj]
 |    |
 |    | select /[prj]/[subprj], [subprj]
 |    |
 |    +--> recursing change directories/sub projects
 |
 |
 +--> job ls, task: ls, cd, add, del,
      |
      | cd [task]
      |
      +--->
      |
      +---> control ways and issues



```


## commands-mode

### first cmds

| commands name | meaning |
|---------------|---------|
|task| list of should i do|
|issue| list of issue link with task
|prj | list of task grouping with strcuture |
|tidy| tidy up tasks|

### task in task

- `task`: All Tasks
- `task -l`: All Tasks with core information
- `task -a|all`: globaly task list
- `task -1`: show nested tasks 1st depth
- `task -2`: show nested tasks 2nd depth

### task commands args

- `tsksh task [id] way`: show list of way for resolve issue
- `tsksh task [id] issue`: show issue link with task
- `project [prj name]`: show only the project
-
- `task sort [algorithm]`: sort task by algorihm
- `task view tree [specific task id]`: show tree strucure
- `task graph tree [specific task id]`: show graph strucure with dot language
