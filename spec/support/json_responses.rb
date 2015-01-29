def birthday_json(person)
  {
    'name'                 => person.name,
    'uuid'                 => person.uuid,
    'thumbnail_url'        => person.thumbnail_image.to_s,
    'date_of_birth'        => person.date_of_birth.in_time_zone.to_i,
    'date_of_birth_string' => person.date_of_birth.to_s,
    'day_of_week'          => person.birthday.current.strftime("%A"),
    'birthday'             => person.birthday.current.in_time_zone.to_i,
    'birthday_string'      => person.birthday.current.to_s,
    'age'                  => person.birthday.count,
    'link'                 => "/v1/people/#{person.uuid}"
  }
end
