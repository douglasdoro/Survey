namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    require 'ffaker'
  
    # Randon True or false
    true_or_false = lambda { [true, false][rand(2)] }
    
    # Erase database
    User.destroy_all
      
    # Fill users table
    3.times do
      user = User.new
      user.name = true_or_false.call ? Faker::Name.name : ""
      user.email = Faker::Internet.email 
      user.password = "123456"
      user.created_at = 1.years.ago..Time.now
      user.save
    end

    # Default user
    User.create! do |user|
      user.name = true_or_false.call ? Faker::Name.name : ""
      user.email = "foo@gmail.com"
      user.password = "123456"
      user.created_at = 1.years.ago..Time.now
    end
    
  end
end