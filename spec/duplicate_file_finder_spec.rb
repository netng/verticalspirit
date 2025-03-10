require_relative '../duplicate_file_finder' # Import the main script
require 'fileutils'

RSpec.describe DuplicateFileFinder do
  let(:test_dir) { "spec/test_files" } # Define a test directory

  before do
    FileUtils.mkdir_p(test_dir) # Create the test folder

    # Create files with duplicate content
    File.write("#{test_dir}/file1.txt", "abcdef")
    File.write("#{test_dir}/file2.txt", "abcdef")
    File.write("#{test_dir}/file3.txt", "abcdef")

    # Create files with different content
    File.write("#{test_dir}/file4.txt", "xyz123")
    File.write("#{test_dir}/file5.txt", "xyz123")
    File.write("#{test_dir}/file6.txt", "hello")
  end

  after do
    FileUtils.rm_rf(test_dir) # Clean up the test folder after each test
  end

  it "counts files with the same content" do
    finder = DuplicateFileFinder.new(test_dir)

    expect { finder.run }.to output("abcdef 3\n").to_stdout
  end

end

