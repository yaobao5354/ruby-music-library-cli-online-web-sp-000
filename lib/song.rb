
class Song

  attr_accessor :name, :genre, :artist

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    if artist
      self.artist = artist
    end
    if genre
      self.genre = genre
    end
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
    song = self.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.songs << self
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if genre.songs.include?(self) != true
        genre.songs << self
    end
  end

  def self.find_by_name(name)
    Song.all.detect{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    result = self.find_by_name(name)
    if result == nil
      self.create(name)
    else
      result
    end
  end


  def self.new_from_filename(filename)
    filename = filename.split(" - ")
    name = filename[1]
    artist = Artist.find_or_create_by_name(filename.first)
    genre = Genre.find_or_create_by_name(filename.last.split(".").first)
    self.new(name, artist, genre)
  end

  def self.create_from_filename(filename)
    @@all << self.new_from_filename(filename)
  end
end
