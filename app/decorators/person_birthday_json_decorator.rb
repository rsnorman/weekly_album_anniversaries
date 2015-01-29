class PersonBirthdayJsonDecorator

  def initialize(people)
    @people = people
  end

  def to_api_json
    Jbuilder.encode do |json|
      json.array! @people do |person|
        json.(person, :name)
        json.set!(:thumbnail_url, person.thumbnail_image.to_s)
        json.set!(:date_of_birth, person.date_of_birth.to_time.to_i)
        json.set!(:age, person.birthday.count)
        json.set!(:day_of_week, person.birthday.current.strftime("%A"))
        json.set!(:birthday, person.birthday.current.to_time.to_i)
      end
    end
  end

end