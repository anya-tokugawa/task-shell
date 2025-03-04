# task-shell

unix-like fastly, sortly, and powerful foss-integration task management command tool

## concept

### Mainly Difference

- unix-like fastly, sortly, and powerful foss-integration tool
- stocktaking
  - all task stocktaking
- support some-orianted priority
  - deadline-oriented
  - deadline+priority
  - pure priority
- support task depenency management
  - tree-oriented
  - graph-oriented
- material list for resolving task
  - issue
  - solution
- remined webhook
  - ntfy
  - smtp
- reporting
  - diary, reporting tasks
- classify job

### Arrangement

- by, projects
  - project needs
    - goal setting
    - milestone
      - milestone connected dependency task id
    - steakholder
      - regime

- project in project
  - project is folder.
    - `cd project_name`

### Tracker

- tracking and, notify schedule
  - mtg notify(10min before end)
  - pomodoro

### Interoperability

- document, chat links
- generate all task list as html or markdown

#### mobility

TODO

#### few motivation

- VTASK, VJOURNAL

## self descussion

### whats difference task and solution for issue?

- task: object of should i **do**.
  - task meaning 2 case.
    1. have a goal, judgement required.
      - judument need to materials(procure sub task belonging 'way').
        - calling as job
    2. doing, implementing it honesty.

- solution: object of **best way for goal**.
  - way: one of the object for resolve issue.
    - issue: object of preventing Goal, having some detailed/specific problem.

#### job meaning

job meaning some case.

1. classfication items of mainly working categories
　　- i called as 'duty'.
2. **task grouping, a batch processing**
   - with judgement required and goal set.

## CLI Design

check [CLI Design](./docs/cli-design.md)
