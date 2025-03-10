require_relative '../duplicate_file_finder'
require 'fileutils'

RSpec.describe DuplicateFileFinder do
  let(:test_dir) { "spec/test_files" }

  before do
    # Nested folders, lets try :p
    FileUtils.mkdir_p("#{test_dir}/folder1/folder1.1")
    FileUtils.mkdir_p("#{test_dir}/folder2")

    # Create files in root directory
    File.write("#{test_dir}/file1.txt", "abcdef")
    File.write("#{test_dir}/file2.txt", "abcdef")

    # Create files in folder1
    File.write("#{test_dir}/folder1/file1.txt", "abcdef")
    File.write("#{test_dir}/folder1/file2.txt", "xyz123")

    # Create files in folder1.1
    File.write("#{test_dir}/folder1/folder1.1/file1.txt", "abcdef")
    File.write("#{test_dir}/folder1/folder1.1/file2.txt", "xyz123")

    # Create files in folder2
    File.write("#{test_dir}/folder2/file1.txt", "hello")
  end

  after do
    FileUtils.rm_rf(test_dir)
  end

  it "counts files with the same content across nested directories" do
    finder = DuplicateFileFinder.new(test_dir)

    expect { finder.run }.to output("abcdef 4\n").to_stdout
  end

  it "returns a message if no duplicate files are found" do
    FileUtils.rm_rf(test_dir)
    FileUtils.mkdir_p(test_dir)

    finder = DuplicateFileFinder.new(test_dir)

    expect { finder.run }.to output("No duplicate files found\n").to_stdout
  end


  it "returns an error when the directory does not exist" do
    expect { DuplicateFileFinder.new("invalid_dir") }.to raise_error(ArgumentError, "Error: Directory 'invalid_dir' does not exist.")
  end
end

