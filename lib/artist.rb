
class Artist

  attr_accessor :name, :songs, :genres
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
    artist = self.new(name)
    artist.save
    artist
  end


  # def artist=(artist)
  #  @artist = artist
  #  artist.songs << self
  #  artist.add_song(self)
#  end

  def add_song(song)
    if !self.songs.include?(song) && !song.artist
      song.artist = self
      #self.songs << song
    end


    #if song.artist !=self
    #  song.artist = self
    #  self.songs << song
    #end
  end

  def genres
    genres_array = []
    self.songs.each do |song|
      if genres_array.include?(song.genre) != true
        genres_array << song.genre
      end
    end
    genres_array
  end

end
