namespace :db do
  desc "Earse and populate the database"
  task :populate => :environment do
    require "factory_girl_rails"
    [User, Post, Tournament, Signup].each(&:delete_all)


    user = Factory(:user, username: "darthdeus", password: "admin", race: "Zerg")
    user.grant :tournament_admin

    salt = BCrypt::Engine.generate_salt

    User.populate 15 do |user|
      user.email         = Faker::Internet.email
      user.username      = user.email.sub(/@.*/, '')
      user.password_hash = BCrypt::Engine.hash_secret("secret", salt)
      user.password_salt = salt
      user.bnet_username = user.username
      user.bnet_code     = [123, 321, 432, 546, 432]
      user.race          = ["Zerg", "Terran", "Protoss", "Random"]
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

    # Create one testing tournament that is already running
    Factory(:tournament, starts_at: 10.minutes.ago)

    Tournament.populate 5 do |tournament|
      tournament.name = Populator.words(2..5)
      tournament.starts_at = 1.day.from_now..5.days.from_now
    end

    Tournament.all.each do |tournament|
      8.times do
        Factory(:signup, tournament: tournament, user: users.sample, status: 1)
      end
    end


  end

end
