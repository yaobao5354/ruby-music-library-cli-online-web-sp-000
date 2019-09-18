class MusicLibraryController

  attr_accessor :path

  def initialize(path="./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
    while input != "exit"
      if input == "list songs"
        self.list_songs
      elsif input == "list artists"
        self.list_artists
      elsif input == "list genres"
        self.list_genres
      elsif input == "list artist"
        self.list_songs_by_artist
      elsif input == "list genre"
        self.list_songs_by_genre
      elsif input == "play song"
        self.play_song
      end
      input = gets.strip
    end
  end

  def list_songs
    list = Song.all.sort{|a,b| a.name <=> b.name}
    list.each.with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    list = Artist.all.sort{|a,b| a.name <=> b.name}
    list.each.with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    list = Genre.all.sort{|a,b| a.name <=> b.name}
    list.each.with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input_name = gets.strip
    Artist.all.detect do |artist|
      if artist.name == input_name
        list = artist.songs.sort{|a,b| a.name <=> b.name}
        list.each.with_index do |song, index|
          puts "#{index+1}. #{song.name} - #{song.genre.name}"
        end
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input_name = gets.strip
    Genre.all.detect do |genre|
      if genre.name == input_name
        list = genre.songs.sort{|a,b| a.name <=> b.name}
        list.each.with_index do |song, index|
          puts "#{index+1}. #{song.artist.name} - #{song.name}"
        end
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    if input.is_a?(Integer) == true
      list = Song.all.sort{|a,b| a.name <=> b.name}
      list.each.with_index do |song, index|
        if index+1 == input
          puts "Playing #{song.name} by #{song.artist.name}"
        end
      end
    end
  end
end
