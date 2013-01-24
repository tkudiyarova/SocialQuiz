namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    99.times do |n|
      name  = Faker::Name.name
      email = "name-#{n+1}@gmail.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence(5)
      users.each { |user| user.questions.create!(title: title) }
    end
  end
end