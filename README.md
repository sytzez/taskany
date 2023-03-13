# Taskany

> Get more done with Taskany's project management tools

Taskany is a Jira/Trello/Clickup/etc. clone for me to try out Rail's Turbo functionalities.

## Features

- Create user accounts and sign in.
- Create projects.
- Create tasks in a project, with descriptions and story points.
- Assign a task to a user.
- Put tasks in different columns by changing its status.
- See how many story points there are in each column.
- Live updates.

## Technologies used

`Rails` `Sass` `ViewComponent` `Devise` `Rspec` `FactoryBot`

## Data model

- User: a standard devise User
  - tasks: hasMany(Task)
- Project
  - title
  - tasks: hasMany(Task)
- Task
  - project: belongsTo(Project)
  - assigned_user: belongsTo(User)
  - title
  - description
  - storyPoints
  - status: enum

## View components

- Board: shows a board, composed of columns for each status.
- Column: shows tasks for one status.
