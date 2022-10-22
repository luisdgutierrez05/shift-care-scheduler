# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Manager
AdminUser.create(email: 'manager@example.au', password: '123123', password_confirmation: '123123', name: 'Manager')

# Plumbers
plumber_one = Plumber.create(
  email: 'mark-logan@example.com',
  name: 'Mark Logan',
  address: 'Beverley Park Golf Club, 87a Jubilee Avenue, 2217'
)
plumber_two = Plumber.create(
  email: 'harry-tally@example.com',
  name: 'Harry Tally',
  address: '63 Townson Road, 2765'
)
plumber_three = Plumber.create(
  email: 'bryan-cameron@example.com',
  name: 'Bryan Cameron',
  address: '51 Irwin Street, 2747'
)

# Clients
client_one = Client.create(
  email: 'joshm@example.com',
  name: 'Josh Milton',
  age: 33,
  private_note: 'Private note',
  address: 'Nour, 490 Crown Street, 2010'
)
client_two = Client.create(
  email: 'avim@example.com',
  name: 'Avi Macquire',
  age: 43,
  private_note: 'Private note',
  address: '159 Rooty Hill Road South, 2766'
)
client_three = Client.create(
  email: 'rachel-drew@example.com',
  name: 'Rachel Drew',
  age: 55,
  private_note: 'Private note',
  address: '6 Leawill Place, 2111'
)

# Jobs
Job.create(
  description: 'kitchen issue',
  date: Date.current + 1.day,
  client: client_one,
  plumber_ids: [plumber_one.id]
)
Job.create(
  description: 'back yard issue',
  date: Date.current + 2.day,
  client: client_two,
  plumber_ids: [plumber_two.id]
)
Job.create(
  description: 'bathrooms issue',
  date: Date.current + 4.day,
  client: client_three,
  plumber_ids: [plumber_one.id, plumber_three.id]
)
