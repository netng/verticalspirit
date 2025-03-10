require 'digest'
require 'find'

class DuplicateFileFinder
  # Struct for cleaner hash storage
  FileData = Struct.new(:count, :sample_content)

  attr_reader :directory, :content_hash

  def initialize(directory)
    raise ArgumentError, "Error: Directory '#{directory}' does not exist." unless Dir.exist?(directory)

    @directory = directory
    @content_hash = Hash.new { |hash, key| hash[key] = FileData.new(0, nil) }
  end

  def run
    scan_files
    puts most_common_file
  end

  private

  def scan_files
    Find.find(directory) do |file_path|
      # Skip directories, only process files
      next unless File.file?(file_path)

      process_file(file_path)
    end
  end

  def process_file(file)
    hash = Digest::SHA256.file(file).hexdigest

    # Include file size to avoid false positives
    file_size = File.size(file)
    content_hash_key = "#{hash}-#{file_size}"

    content_hash[content_hash_key].count += 1

    # Read first 100 bytes for preview
    content_hash[content_hash_key].sample_content ||= File.open(file, "rb") { |f| f.read(100) }
  end

  def most_common_file
    most_common = content_hash.max_by { |_, v| v.count }
    most_common ? "#{most_common[1].sample_content.strip} #{most_common[1].count}" : "No duplicate files found"
  end
end

# Execute the program
if __FILE__ == $0
  begin
    directory_path = ARGV[0] || "."
    DuplicateFileFinder.new(directory_path).run
  rescue ArgumentError => e
    puts e.message
  end
end

