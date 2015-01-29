def random_weekly_birthday
  Date.current.end_of_week(:sunday) + rand(1..6).days - rand(30..50).years
end

people = [
  "Cosmo Kramer", "Jerry Seinfeld", "Elaine Benes", "George Costanza",
  "Newman", "Frank Costanza", "Morty Seinfeld", "Uncle Leo", "Jackie Chiles",
  "David Puddy", "Tim Whatley", "Estelle Costanza", "Helen Seinfeld"
]

Client.destroy_all
Person.destroy_all

client = Client.create!(name: "Seinfeld Cast", week_start_preference: "sunday")

people.each do |person|

  unless Person.where(:name => person).count > 0
    Person.create!(client:        client,
                   name:         person,
                   thumbnail:     "#{person.downcase.gsub(' ', '_')}.jpg",
                   date_of_birth: random_weekly_birthday)
    puts "Create #{person}"
  else
    puts "#{person} already exists"
  end

end
