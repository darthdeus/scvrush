namespace :db do
  desc "Earse and populate the database"
  task :populate => :environment do
    [User, Post].each(&:delete_all)
    
    Post.populate 10 do |post|
      post.title    = Populator.words(3..7)
      post.content  = Populator.paragraphs(2..5)
    end

    Post.all.each do |post|
      post.tag_list = "foo,bar,baz"
    end

    6.times do
      post = Factory(:post)
      post.tag_list = ["coach,na,zerg", "coach,eu,zerg,terran","coach,na,protoss"].sample
    end
    
    salt = BCrypt::Engine.generate_salt
    
    User.populate 1 do |user|
      user.email         = Faker::Internet.email
      user.username      = user.email.sub(/@.*/, '')
      user.password_hash = BCrypt::Engine.hash_secret("secret", salt)
      user.password_salt = salt
    end  
  end
  
end