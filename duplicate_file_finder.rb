require 'digest'
require 'find'

def DuplicateFileFinder
  def initialize(directory)
    @directory = directory
    @content_hash = Hash.new { |hash, key| hash[key] = { count: 0, sample_content: nil } }
  end


end
