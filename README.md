# Taskany

> Get more done with Taskany's project management tools

Taskany is a Jira/Trello/Clickup/etc. clone for me to try out Rail's Turbo functionalities.

## Features

- Create user accounts and sign in.
- Create projects.
- Create tasks in a project, with descriptions and story points.
- Assign a task to a user.
- Put tasks in different columns by changing its state.
- See how many story points there are in each column.
- Live updates.

## Data model

- User: a standard devise User
- Project
  - title
  - tasks: hasMany(Task)
- Task
  - project: belongsTo(Project)
  - title
  - description
  - storyPoints
