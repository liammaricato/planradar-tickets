# PlanRadar Tickets

PlanRadar Tickets is a simple MVP Rails application that allows you to create tickets and send reminders to users based on each user's individual reminder preferences. Reminders are currently sent via email, but we can easily add more notification methods later.

This is part of a technical assessment from Pennylane. The test requirements can be found on the `Assessment.md` file.

The app is built with **Rails 8**, and uses **GoodJob** for background job processing. The mailing is done via ActionMailer, and e-mails are caught by **Mailcatcher** so we can display them in the browser.

## 💻 Technical stack

- **Web framework:** Ruby on Rails
- **Database:** PostgreSQL
- **Testing:** RSpec
- **Background job processing:** GoodJob
- **E-mail catching:** Mailcatcher

## 🛠 Setup

The development environment is set up to use Docker Compose, so all you need to have is **Docker** installed and running. Once that's done, there are a few scripts to help you get started.

First we need to build and run the development environment:
```bash
bin/dev build

# or run the docker compose file directly
docker compose -f docker-compose-dev.yml up --build
```

This puts up a few containers:
- `web` - The Rails application
- `db` - The PostgreSQL database
- `mailcatcher` - A mailcatcher SMTP server to catch emails sent by the application

The server won't be available yet, but we can shell into the container in a different terminal session to put everything up:
```bash
bin/dev shell

# or run the docker compose file directly
docker compose -f docker-compose-dev.yml exec web bash
```

That puts us inside the container with the whole project in the root directory. Now run the following script to quickly configure dependencies, database, and start the server:
```bash
bin/setup
```

This will install dependencies, prepare the database, and start the server. If you'd like to see what it does, or prefer to do it manually, you can always check out the `bin/setup` script.

> Now our server is up and running! 🎉

We can access it through `http://localhost:3000`.

*To get the full experience, I suggest you also check out:*
- The mailcatcher interface at `http://localhost:1080` to see the e-mails being sent by the application
- The GoodJob UI at `http://localhost:3000/good_job` to keep an eye on the background jobs being processed

## 📱 App usage

The app interface is pretty simple, but allows us to manage users and tickets. This includes creating, updating, and deleting both of the resources.

The seeded data includes a few users with different reminder preferences and timezones, and a ticket for each one. Based on the date of seed, all tickets are going to be due in the same day.

To see it in action, I suggest messing around with the user's reminder preferences. Each ticket will only be notified once, and the reminder will be sent at the time specified in the user's reminder preferences.

#### Reminders are sent following this logic:
- If the reminder is enabled for the user
- If the ticket is due today, based on:
  - Ticket's due date
  - User's reminder interval (how many days before the due date to send the reminder)
  - User's reminder time (the time of day to send the reminder)
  - User's timezone

> Keep in mind that some timezones might include daylight saving time, so the reminder time might be different depending on the time of year.

#### Ticket status
All tickets start as `open` (stauts_id: 0), and once they're notified, they're set to `notified` (status_id: 1). There's one last status for `closed`(status_id: 2). I created an enum for the statuses on the Model, but it isn't fully utilized yet, there's no transition scenario for the `closed` status.

Once a Ticket has been notified, it's `notified` status keeps it from being notified again, *unless!*

In case you'd like to see e-mails being sent with disregard to the ticket's status, there's a development flag for Users to enable it. Just go to the user's edit page, and check the `Recurring reminder` checkbox. *Keep in mind that it will send reminders every minute for due tickets from that user.*

## 🧪 Running the tests

There's a simple script to put the test database up and run the full specs. Of course, I suggest running it inside the `web` container we've put up.
```bash
bin/test
```

Once again, if you prefer to do it manually, you can always check out this `bin/test` script to see how it's done.

## 📚 References
- Pattern used for the commit emojis: [😍 gitmoji.dev](https://gitmoji.dev/)
