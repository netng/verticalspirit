require 'digest'
require 'find'

class DuplicateFileFinder
  attr_reader :directory, :content_hash

  def initialize(directory)
    @directory = directory
    @content_hash = Hash.new { |hash, key| hash[key] = { count: 0, sample_content: nil } }
  end

  def run
    scan_files
    puts most_common_file
  end

  private

  def scan_files
    Find.find(directory) do |file|
      next unless File.file? file

      process_file(file)
    end
  end

  def process_file(file)
    hash = Digest::SHA256.file(file).hexdigest
    content = File.open(file, "rb") { |f| f.read(100) }

    content_hash[hash][:count] += 1
    content_hash[hash][:sample_content] ||= content

  end

  def most_common_file
    most_common = content_hash.max_by { |_, v| v[:count] }
    most_common ? "#{most_common[1][:sample_content].strip} #{most_common[1][:count]}" : "No duplicate files found" 
  end
end

# Execute the program
if __FILE__ == $0
  directory_path = ARGV[0] || "."
  DuplicateFileFinder.new(directory_path).run
end
