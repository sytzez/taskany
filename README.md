# Taskany

> Get more done with Taskany's project management tools

Taskany is a Jira/Trello/Clickup/etc. clone for me to try out Rails' Turbo functionalities.

## Features

- Create user accounts and sign in.
- Create projects. [spec](/spec/features/projects_spec.rb)
- Create tasks in a project, with descriptions and story points, and assign them to users. [spec](/spec/features/tasks_spec.rb)
- Tasks go to different columns based on their status. Each column shows the sum of story points. [spec](/spec/components/column_component_spec.rb)
- Live updates to the board when other people make changes.

## Technologies used

`Rails` `Hotwire` `Sass` `ViewComponent` `Devise` `Rspec` `FactoryBot`

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
