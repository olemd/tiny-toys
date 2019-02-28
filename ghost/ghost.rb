#!/usr/bin/env ruby

# Tiny toy that hides itself when running
# Basically a demonstration of File::unlink
#
# Pretty much no error-handling, breaks in case
# * Unable to read/write self
# * Unable to write to proper directory
# * Doesn't set the right mode on the new file, will lose executableness

# Get a file handle for $PROGRAM_NAME
@thisfile = File.open($PROGRAM_NAME, "r")

# Register at_exit function
at_exit do
  puts "Revealing myself."
  File.write($PROGRAM_NAME, @thisfile.read)
  puts "Back!"
  Dir.foreach(File.dirname($PROGRAM_NAME)) do |thing|
    puts thing
  end
end

# Find the directory where the program is running from
dir = File.dirname($PROGRAM_NAME)

# Show current contents of directory
puts "Look!"
Dir.foreach(dir) { |thing| puts thing }

# Unlink, and show result
File.unlink($PROGRAM_NAME)
puts "Playing peekaboo with #{$PROGRAM_NAME}"
Dir.foreach(dir) { |thing| puts thing}

# Wait a bit so user can check self
sleep 20
