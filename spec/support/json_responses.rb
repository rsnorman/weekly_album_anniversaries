def birthday_json(person)
  {
    'name'          => person.name,
    'thumbnail_url' => person.thumbnail_image.to_s,
    'date_of_birth' => person.date_of_birth.to_time.to_i,
    'day_of_week'   => person.birthday.current.strftime("%A"),
    'birthday'      => person.birthday.current.to_time.to_i,
    'age'           => person.birthday.count
  }
end
