#!/usr/bin/env ruby
# Inspired by: https://gist.github.com/dvdsgl/4600317

require 'fileutils'
require 'ruby-filemagic'

# No changes are made unless -f is specified
DRY = !(ARGV.include? "-f")

# Replace all occurrences of this with that in file.
def replace file, this, that
  content = File.read file
  if content.include?(this) && !is_binary?(file)
    puts "#{file} (#{content.scan(this).count} occurrences of '#{this}')"
    unless DRY
      content.gsub! this, that
      File.open(file, "w") { |f| f.puts content }
    end
  end
end

# Rename a file or directory
def mv x, y
  cmd = "mv #{x} #{y}"
  puts cmd
  `#{cmd}` unless DRY
end

def rename dir, this, that
  Dir.chdir dir do
    dirs = Dir["*"].select { |f| File.directory? f }
    files = Dir["*"].reject { |f| File.directory?(f) || f == "setup_new_project.rb" }
    # Traverse subdirectories
    dirs.each do |sub|
      rename sub, this, that
    end
    # Change file contents
    files.each do |f|
      replace f, this, that
    end
    # Rename files in this directory
    Dir["*#{this}*"].each do |f|
      mv f, f.sub(this, that)
    end
  end
end

def is_binary?(filename)
  begin
    fm = FileMagic.new(FileMagic::MAGIC_MIME)
    fm.file(filename) !~ /^text\//
  ensure
    fm.close
  end
end

def setup_config_files
  puts "Setting up configuration files"
  `./BoosterKit/Config/check_config_files.rb` unless DRY
end

def setup_pods
  puts "Removing Pods Directory"
  FileUtils.remove_dir("Pods") unless DRY

  puts "rm Podfile.lock"
  FileUtils.rm("Podfile.lock") unless DRY

  puts 'pod install'
  `pod install` unless DRY
end

arguments = ARGV.reject { |x| x =~ /^-/ }
if arguments.count > 0
  new_name = arguments.first
  dir = "./"
  setup_config_files
  rename dir, "BoosterKit", new_name
  mv dir, dir.sub("BoosterKit", new_name) if dir.include? "BoosterKit"
  setup_pods
  puts "(You must include -f to actually perform the setup)" if DRY
else
  puts "Usage: setup_new_project.rb PROJECT_NAME"
end
