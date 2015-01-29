FactoryGirl.define do
  factory :person do
    name "Ryan"
    date_of_birth Date.current - 30.years
    thumbnail "thumbnail.jpg"
  end

  factory :client do
    name "Ryan"
  end
end
