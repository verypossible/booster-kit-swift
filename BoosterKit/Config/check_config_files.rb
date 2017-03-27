#!/usr/bin/env ruby

require 'fileutils'

# Create default xcconfig files if they're not present.
source_path = 'BoosterKit/Config/CONFIGURATION.example.xcconfig'
destination_path = 'BoosterKit/Config/CONFIGURATION.xcconfig'

['Debug', 'Release', 'BoosterKit'].each do |config|
  source_file = source_path.gsub(/CONFIGURATION/, config)
  destination_file = destination_path.gsub(/CONFIGURATION/, config)

  if !File.file?(destination_file)
    FileUtils.copy source_file, destination_file
  end
end
