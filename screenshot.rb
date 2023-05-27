require 'fileutils'
require 'time'

class Screenshot
  FILES = Regexp.new(/^Screen ?[Ss]hot (\d{4})-(\d{2})-(\d{2})[ at]+(\d{1,2})\.(\d{2})\.(\d{2}) ?(AM|PM)? ?(\(\d+\))?\.png$/)
  SETFILE = '/usr/bin/SetFile'
  SETFILE_EXISTS = File.exist?(SETFILE)

  class << self
    def find_in_dir(dir_name)
      files = Dir.glob('*.png', base: dir_name)
      files.select { |file| FILES.match(file) }
    end

    def new_name(file_name)
      return nil unless (match = FILES.match(file_name))

      hour = match[4].to_i
      hour += 12 if match[7] == 'PM' && hour != 12
      hour = hour.to_s.rjust(2, '0')

      "#{match[1]}-#{match[2]}-#{match[3]} #{hour}.#{match[5]}.#{match[6]}#{' ' if match[8]}#{match[8]}.png"
    end

    def run(dir_name = nil)
      dir_name ||= File.expand_path('~/Desktop')
      find_in_dir(dir_name).each do |old_file_name|
        new_file_name = new_name(old_file_name)
        rename File.expand_path(old_file_name, dir_name), File.expand_path(new_file_name, dir_name)
      end
      return unless SETFILE_EXISTS

      system "#{SETFILE} -a E #{dir_name}/20*.png"
    end

    private

    def rename(old_file, new_file)
      puts "Renaming #{old_file} -> #{new_file}"
      FileUtils.mv(old_file, new_file)
    end
  end
end
