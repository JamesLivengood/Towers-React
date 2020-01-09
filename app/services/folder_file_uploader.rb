class FolderFileUploader
  attr_reader :dir_name

  def initialize(dir_name)
    @dir_name = dir_name
  end

  def upload!
    Dir.foreach(dir_name) do |filename|
      next if ['.', '..', '.DS_Store', "image2.csv"].include?(filename)
      @filename = filename
      if filename.include? "Tower"
        save_towers!(filename)
      else 
        save_transmitters!(filename)
      end 
    end
  rescue => e
    puts @filename
    raise e
  end

  private

  def save_towers!(filename)
    CSV.open(dir_name + filename, 'r', headers: true).each do |tower|
      Tower.create(tower.to_h.delete_if { |k, v| !k || k.empty? })
    end
  end 

  def save_transmitters!(filename)
    CSV.open(dir_name + filename, 'r', headers: true).each do |transmitter|
      Transmitter.create(transmitter.to_h.delete_if { |k, v| !k || k.empty? })
    end
  end 
end
