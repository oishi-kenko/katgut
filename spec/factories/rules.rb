FactoryGirl.define do
  factory :rule, class: Toritsugi::Rule do
    source      'test'
    destination 'https://www.google.com/'
    active      true
  end
end
