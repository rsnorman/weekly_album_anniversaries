class PersonBirthdayJsonDecorator < SimpleDelegator

  def to_api_json
    Jbuilder.encode do |json|
      json.(self, :name, :thumbnail)
      json.set!(:date_of_birth, self.date_of_birth.to_time.to_i)
      json.set!(:age, self.birthday.count)
      json.set!(:birthday, self.birthday.current.to_time.to_i)
    end
  end

end