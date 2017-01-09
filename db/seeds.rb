#User
User.create(name: "Minh la Tung", email: "vtungcntt12t1@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true,
  activated: true,
  created_at: Time.zone.now)
19.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  User.create(name: name, email: email, password: password,
    password_confirmation: password,
    activated: true,
    created_at: Time.zone.now)
end
