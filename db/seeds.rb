# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MOVIES = [
  { title: 'The Fast and the Furious', imdb_id: 'tt0232500' },
  { title: '2 Fast 2 Furious', imdb_id: 'tt0322259' },
  { title: 'The Fast and the Furious: Tokyo Drift', imdb_id: 'tt0463985' },
  { title: 'Fast & Furious', imdb_id: 'tt1013752' },
  { title: 'Fast Five', imdb_id: 'tt1596343' },
  { title: 'Fast & Furious 6', imdb_id: 'tt1905041' },
  { title: 'Furious 7', imdb_id: 'tt2820852' },
  { title: 'The Fate of the Furious', imdb_id: 'tt4630562' }
].freeze

user = User.create!(username: 'jon_doe', password: ENV['USER_PASSWORD'])

user.movies.create!(MOVIES)
