namespace :dev do

  task fake_restaurant: :environment do
    Restaurant.destroy_all

    30.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end


  task fake_user: :environment do
    Comment.destroy_all
    User.destroy_all

    User.create!(email: "test@test",
        password: "testtest",
        name: "testman",
        intro: "admin account for test.",
        role: "admin",
      )

    20.times do |i|
      User.create!(email: FFaker::Internet.email,
        password: 12345678,
        intro: FFaker::Lorem.paragraph,
        name: FFaker::Name.first_name,
      )
    end
    puts "have created fake Users"
    puts "now you have #{User.count} users data"
  end

  task fake_comment: :environment do

    @restaurants = Restaurant.all
    @restaurants.each do |restaurant|
      3.times do |i|
        Comment.create!(content: FFaker::Lorem.paragraph,
          restaurant_id: restaurant.id,
          user_id: User.pluck(:id).sample(1)[0],
        )
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data"
  end

end