namespace :db do

  desc "Earse and populate the database"
  task :populate => :environment do
    require "factory_girl_rails"

    [User, Post, Tournament, Signup, Coach].each(&:delete_all)

    user = FactoryGirl.create(:user, email: "darthdeus@gmail.com",
                              username: "darthdeus", password: "password",
                              race: "Zerg", league: "Diamond")
    user.grant :tournament_admin
    user.grant :admin

    10.times do
      FactoryGirl.create(:status)
    end

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

    BlogPost.populate 4 do |post|
      post.title = Populator.words(3..7)
      post.url   = "http://example.com"
      post.order = 0
    end

    Post.populate 10 do |post|
      post.title        = Populator.words(3..7)
      post.content      = Populator.paragraphs(2..5)
      post.status       = Post::PUBLISHED
      post.published_at = Time.now

      Comment.populate 5 do |comment|
        comment.content = Populator.paragraphs(1..3)
        comment.post_id = post.id
        comment.user_id = users.sample.id
      end
    end

    Post.all.each do |post|
      post.tag_list = %w{zerg terran protoss}.sample
      post.save
    end

    6.times do
      post = FactoryGirl.create(:post)
      post.tag_list = ["coach,na,zerg", "coach,eu,zerg,terran","coach,na,protoss"].sample
    end

    # Create one testing tournament that is already running
    FactoryGirl.create(:tournament, starts_at: 10.minutes.ago)

    Tournament.populate 5 do |tournament|
      tournament.name = Populator.words(2..5)
      tournament.starts_at = 1.day.from_now..5.days.from_now
      tournament.tournament_type = Tournament::TYPES
      tournament.bo_preset = "1"
      tournament.map_preset = "foo"
    end

    Tournament.all.each do |tournament|
      8.times do
        FactoryGirl.create(:signup, tournament: tournament, user: users.sample, status: 1)
      end
    end

    Coach.populate 10 do |coach|
      post = FactoryGirl.create(:post)

      coach.title    = Faker::Name.name
      coach.post_id  = post.id
    end

  end

end
