# Data Structure

## File Structure

```
/var/task-shell
  |
  +-- 
 
```

```
task 1<-->N task
task 1<-->N issue
way 1<-->N task
job 1<-->M task
prj 1<-->N task
prj 1<-->N prj
```

## Task

| column |  data | description |
|--------|-------|-------------|
| ptype | str | `root`,`way`,`job`,`prj`|
| pid | uuid | Parent ID Pointer |
| id | uuid | task id
| name | hexed str | task name |
| links | url list with link name | task url
| tags | hexed str list | tag list |
| deadline | unixtime | deadline
| showastime | unixtime | hide until this time
| completetime | unixtime | for reporting
| lastdiary | unixtime | lastdiary date
| laststocktakingtime |  unixtime | last stocktaking time
| priority | 0-5  | pure priority
| ctaskid | id list | child task
| cissueid | id issue | child issue

```
ptype,pid,id\n
name\n
enc_text|link\tenc_text|link....\n
tag\ttag\t...\n
priority,deadline,showastime,completetime\n
lastdiary,laststocktakingtime\n
ctaskid|ctaskid|ctaskid...\n
cissueid|cissueid|cissueid...
```

### markdown docs

`path/to/docs/{id}.md`
### diary

`path/to/diary/{id}/{yyyy-mm-dd}.md`

## Project

| column |  data | description |
|--------|-------|-------------|
| ptype | str | `root`,`way`,`job`,`prj`|
| pid | uuid | Parent ID Pointer |
| id | uuid | task id
| name | hexed str | task name |
| links | url list with link name | task url
| tags | hexed str list | tag list |
| deadline | unixtime | deadline
| showastime | unixtime | hide until this time
| completetime | unixtime | for reporting
| lastdiary | unixtime | lastdiary date
| laststocktakingtime |  unixtime | last stocktaking time
| priority | 0-5  | pure priority
| ctaskid | id list | child task
| cprjid | id issue | child issue



