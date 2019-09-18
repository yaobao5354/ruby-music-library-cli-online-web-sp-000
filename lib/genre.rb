class Genre

  attr_accessor :name, :songs, :artists
  extend Concerns::Findable
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end

  def artists
    artists = []
    self.songs.each do |song|
      if artists.include?(song.artist) != true
        artists << song.artist
      end
    end
    artists
  end

end
