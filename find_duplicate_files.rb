require 'digest'
require 'find'

def count_duplicate_files(directory)
  content_hash = Hash.new(0)

  Find.find(directory) do |file|
    next unless File.file?(file)

    hash =
      Digest::SHA256
      .file(file)
      .hexdigest

    content_hash[hash] += 1
  end

  most_common_content = content_hash.max_by  { |_, count| count }
  puts "#{most_common_content[0]} #{most_common_content[1]}" if most_common_content
end

directory_path = ARGV[0] || "."
count_duplicate_files(directory_path)
