class User
  attr_accessor :name
  attr_accessor :address
  attr_accessor :video_game
  attr_accessor :profile

  extend Demeter

  def initialize
    @video_game = VideoGame.new
    @address = Address.new
    @profile = Profile.new
  end
end

class Address
  attr_accessor :street
  attr_accessor :city
  attr_accessor :country
  attr_accessor :state
  attr_accessor :zip_code
end

class VideoGame
  attr_accessor :title
end

class Profile
  attr_accessor :interests
end
