FactoryGirl.define do
  factory :album do
    sequence(:name) { |n| "Kid A #{n}" }
    artist
    release_date Date.current - 30.years
    thumbnail "thumbnail.jpg"
    rating 8.8
    link "http://pitchfork.com/review/kida"
  end

  factory :artist do
    sequence(:name) { |n| "Radiohead #{n}" }
  end

  factory :genre do
    name "Indie"
  end
end
