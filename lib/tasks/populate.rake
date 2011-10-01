namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    require 'ffaker'
    require 'populator'
    
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
    
    # Fill surveys table
    Survey.populate 5 do |survey|
      survey.name = Populator.words(2..3).titleize
      survey.description = Populator.words(10..20).titleize
      survey.published = true_or_false.call
      survey.user_id = User.order("RANDOM()").first.id      

      # Fill questions table
      Question.populate 1..2 do |question|
        question.survey_id = survey.id
        question.content = Populator.words(5..8).titleize << "?"

        # Fill Answers table
        Answer.populate 1..4 do |answer|
          answer.question_id = question.id
          answer.content = Populator.words(5..8).titleize
        end        
      end
    end
    
  end
end