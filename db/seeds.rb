puts 'Destroying all tickets and users'

Ticket.destroy_all
User.destroy_all

puts 'Creating users'

users = [
  {
    name: 'Test User 1',
    mail: 'test1@example.com',
    due_date_reminder_time: '10:00',
    send_due_date_reminder: true,
    due_date_reminder_recurring: false,
    due_date_reminder_interval: 2,
    timezone: '0'
  },
  {
    name: 'Test User 2',
    mail: 'test2@example.com',
    due_date_reminder_time: '13:00',
    send_due_date_reminder: true,
    due_date_reminder_recurring: false,
    due_date_reminder_interval: 1,
    timezone: '-3'
  },
  {
    name: 'Test User 3',
    mail: 'test3@example.com',
    due_date_reminder_time: '19:00',
    send_due_date_reminder: true,
    due_date_reminder_recurring: false,
    due_date_reminder_interval: 0,
    timezone: '5'
  }
]

user1 = User.create!(users[0])
user2 = User.create!(users[1])
user3 = User.create!(users[2])

puts 'Creating tickets'

user1.tickets.create!(
  title: 'Test Ticket 1',
  due_date: 2.days.from_now
)

user2.tickets.create!(
  title: 'Test Ticket 2',
  due_date: 1.days.from_now
)

user3.tickets.create!(
  title: 'Test Ticket 3',
  due_date: 0.days.from_now
)
