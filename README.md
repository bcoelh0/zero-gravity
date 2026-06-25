# Zero Gravity — School Hub

A teacher onboarding demo for Zero Gravity, built in Rails 8. Two screens that create a social accountability loop inside a school's department hierarchy: teachers work through a first-week checklist, and their Head of Department can see who's activated and who needs a nudge.

## Screens

### Teacher view (`/t/dash`)

A personalised first-week checklist in a persistent split-panel layout. The left panel shows the task list and progress; the right panel loads each task's detail via Turbo Frames — no full-page reloads.

Five purpose-built task pages, each completed by taking the action:

| Step | Task | Completion trigger |
|------|------|--------------------|
| 1 | Set up your first class | Confirm subject + curriculum level dropdowns |
| 2 | Assign your first topic | Type or select a topic chip, click "Set topic →" |
| 3 | Check a student report | Expand any student's AI report, click "Got it →" |
| 4 | Share the AI Tutor | Click "Copy link" (copies join URL + auto-submits) |
| 5 | Weekly email opt-in | Choose "Yes, email me every Monday →" or decline |

**Personalisation** — once step 1 is saved, the subject and curriculum level flow into every subsequent task: step 2's description and suggestion chips update to match the subject; step 4's join link slug and suggested email template use the teacher's saved subject and name.

**Left panel** — progress card shows X/5 done, "~N min left" estimate, and a smooth-fill progress bar. Completed rows show "Completed X days ago". Any task (including done ones) can be clicked to open it in the right panel, where it shows its saved data and a "Re-do this task" link.

**Completing all five tasks** triggers a canvas confetti burst in the right panel.

### HoD view (`/hod/dash`)

A department management screen for the Head of Department.

- **Aggregate progress bar** — segmented green/blue bar showing how many teachers are fully set up, in progress, or not started.
- **Teacher table** — name, email, mini progress bar with "On step N · task name" label, relative last-active time, status badge, and per-row nudge button.
- **Idle highlighting** — teachers inactive for >3 days get an amber left border, amber "N days ago ⚠" timestamp, and a highlighted status badge.
- **Bulk nudge** — "Nudge all not-started (N)" button at the top of the table triggers all per-row nudge buttons at once and shows a consolidated toast.

## Stack

- Ruby on Rails 8.1, SQLite
- Hotwire / Turbo Frames (task navigation) + Turbo Streams (in-place task row, progress card, and detail panel updates on completion)
- Tailwind CSS via CDN with custom `zg-blue`, `zg-green`, `zg-gray` colours
- Teacher identity via cookie (`demo_teacher_id`) set by a demo switcher dropdown in the nav

## Getting started

```bash
bundle install
rails db:create db:migrate db:seed
rails server
```

The seed output prints direct demo URLs for each teacher persona. Navigate to `http://localhost:3000` to start.

## Demo flow

Open in this order for the best presentation:

1. **Sara** — blank slate, most dramatic starting point; walk through all 5 tasks
2. **Priya** — 3/5 in progress, shows saved subject/topic and partial completion state
3. **Dan** — fully activated, confetti already fired; click completed tasks to see saved data
4. **HoD view** — all five teachers across the activation spectrum; demo idle highlighting, "stuck on step N", and the bulk nudge button

## Data model

```
schools           id, name
departments       id, school_id, name
teachers          id, department_id, name, email, role (teacher/hod),
                  subject, curriculum_level, topic,
                  weekly_email_opted_in, last_login_at
onboarding_tasks  id, title, description, position
teacher_task_completions  id, teacher_id, onboarding_task_id, completed_at
```

## Deliberately out of scope

- Real auth (cookie-based for demo; session-based in production)
- Email delivery for nudges and weekly summaries (preferences stored; infra is solved)
- Multi-department views (model supports it; one department seeded to protect demo quality)
- Historical analytics and student-facing features
