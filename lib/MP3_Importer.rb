class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
    @path = path
    @files = []
    Dir.glob("#{@path}/*.mp3").each {|file| @files << file}
  end

  def import
    self.files.each {|file| Song.create_from_filename(file)}
  end

  def files
    @files.collect {|file| file.split("/").last}
  end


end
