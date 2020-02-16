require 'fileutils'
class FolderFileUploader
  attr_reader :dir_name

  def initialize(dir_name ='towers/')
    @dir_name = dir_name
  end

  def upload!
    Dir.foreach(dir_name) do |filename|
      next if ['.', '..', '.DS_Store', "image2.csv"].include?(filename)
      @filename = filename
      if filename.include? "Tower"
        save_towers!(filename)
        FileUtils.mv(dir_name + filename, "towers_processed/#{filename}")
      else 
        save_transmitters!(filename)
        FileUtils.mv(dir_name + filename, "transmitters_processed/#{filename}")
      end
      # SuccesfulDownload.where(tower_filename)
    rescue => e
      FileUtils.mv(dir_name + @filename, "failed_sheets/#{@filename}")
      # raise e
    end
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
