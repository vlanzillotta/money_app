FactoryGirl.define do
  factory :user do
    
    email    "vlanzillotta@gmail.com"
    password "password"
    password_confirmation "password"
    name "Vince"
  end
  factory :user2 , :class => User do
    
    email    "vlanzillotta2@gmail.com"
    password "password2"
    password_confirmation "password2"
    name "Vince2"
  end
end