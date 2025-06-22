# Development Task

PlanRadar is a SaaS application for construction documentation & defect management. Our customers create lots of tickets every day. These tickets are usually created to report a defect and it is assigned to a project member to fix it.

Tickets usually contain fields like (Title, Description, Assignee, Due Date, Status, Progress ...etc.). We want to implement a new feature to send due date reminders emails to the users based on their profile configuration.

### Each user will define the following data:
- Activate / Deactivate due date reminders (Boolean)
- Due date reminder notification interval (Number)
- When to send the reminder? 0 = on due date, 1 = one day before the due date, ... etc.
- Due date reminder time (Time)
- At which time should we send the reminder
- Time Zone (String)
- The user's time zone i.e., Europe/Vienna

Based on the provided info create a module that sends notifications based on the users’ preferences. Keep in mind that in the future we may add new notification methods like (SMS, Push Message, etc.).

### General Notes:
- Push the project to a public GitHub account so we can check it.
- User rails version >= 5.2 and any database type you preferer
- Write specs to test the basic functionality of the new models
- Add a readme file to describe the application and how to run/use it