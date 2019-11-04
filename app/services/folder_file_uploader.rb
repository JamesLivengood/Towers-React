class FolderFileUplaoder
  attr_reader :dir_name

  def initialize(dir_name)
    @dir_name = dir_name
  end

  def upload!
    Dir.foreach('/path/to/dir') do |filename|
      next if filename == '.' or filename == '..'
      # Do work on the remaining files & directories
    end
  end
end