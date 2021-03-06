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

    Post.populate 10 do |post|
      post.title        = Populator.words(3..7)
      post.content      = Populator.paragraphs(2..5)
      post.status       = Post::PUBLISHED
      post.published_at = Time.now
    end

    Post.all.each do |post|
      post.tag_list = %w{zerg terran protoss}.sample
      post.save!
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
      tournament.user_id = User.all.sample.id
    end

    Tournament.all.each do |tournament|
      8.times do
        FactoryGirl.create(:signup, tournament: tournament, user: users.sample, status: 1)
      end
    end
  end

end
