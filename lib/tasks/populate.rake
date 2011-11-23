namespace :db do
  desc "Earse and populate the database"
  task :populate => :environment do
    [User, Post].each(&:delete_all)

    
    Factory(:user, :username => "darthdeus", :password => "admin")
    salt = BCrypt::Engine.generate_salt
    
    User.populate 15 do |user|
      user.email         = Faker::Internet.email
      user.username      = user.email.sub(/@.*/, '')
      user.password_hash = BCrypt::Engine.hash_secret("secret", salt)
      user.password_salt = salt
    end  
    
    users = User.all

    
    Post.populate 10 do |post|
      post.title    = Populator.words(3..7)
      post.content  = Populator.paragraphs(2..5)
      post.status   = Post::PUBLISHED
      
      Comment.populate 5 do |comment|
        comment.content = Populator.paragraphs(1..3)
        comment.post_id = post.id
        comment.user_id = users.sample.id
      end
    end

    Post.all.each do |post|
      post.tag_list = "foo,bar,baz"
    end

    6.times do
      post = Factory(:post)
      post.tag_list = ["coach,na,zerg", "coach,eu,zerg,terran","coach,na,protoss"].sample
    end
    
    Tournament.populate 5 do |tournament|
      tournament.name = Populator.words(2..5)
      tournament.starts_at = 1.day.from_now..5.days.from_now                  
    end
    
    Tournament.all.each do |tournament|
      5.times do
        Factory(:signup, :tournament => tournament, :user => users.sample)
      end
    end
    
    
  end
  
end