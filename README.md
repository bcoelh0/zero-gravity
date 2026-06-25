# Zero Gravity — School Hub

A teacher onboarding demo for Zero Gravity, built in Rails 8. Two screens that create a social accountability loop inside a school's department hierarchy: teachers work through a first-week checklist, and their Head of Department can see who's activated and who needs a nudge.

## Screens

**Teacher view** (`/t/dash?teacher_id=X`) — A personalised first-week checklist with a progress bar that turns green at 5/5. Each task toggles via a Turbo Frame with no full page reload. The footer always reads: *"Your HoD can see your progress."*

**HoD view** (`/hod/dash`) — A department table showing every teacher's name, task progress, last active time, and status badge (Fully set up / In progress / Not started). Three summary stat cards at the top. A one-click "Send a nudge →" button per row triggers a toast confirmation.

## Stack

- Ruby on Rails 8.1, SQLite
- Hotwire / Turbo Frames for task completion toggles
- Tailwind CSS via CDN
- Teacher identity via `?teacher_id=X` URL param (no auth)

## Getting started

```bash
bundle install
rails db:migrate
rails db:seed
rails server
```

The seed output prints exact demo URLs for each teacher persona.

## Demo flow

Open in this order for the best presentation:

1. **Sara** — blank slate, most dramatic starting point
2. **Priya** — 3/5 in progress, shows the checklist working
3. **Dan** — fully activated, green progress bar
4. **HoD view** — all five teachers across the activation spectrum; demo the nudge button live

## Data model

```
schools           id, name
departments       id, school_id, name
teachers          id, department_id, name, email, role (teacher/hod), last_login_at
onboarding_tasks  id, title, description, position
teacher_task_completions  id, teacher_id, onboarding_task_id, completed_at
```

## Deliberately out of scope

- Real auth (session-based in production; URL param for demo)
- Email delivery for nudges (toast only; infra is solved)
- Multi-department views (model supports it; one department seeded to protect demo quality)
- Historical analytics and student-facing features
