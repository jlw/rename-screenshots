require_relative './screenshot'

class ScreenshotCleanshot < Screenshot
  FILES = Regexp.new(/^CleanShot (\d{4})-(\d{2})-(\d{2})[ at]+(\d{1,2})\.(\d{2})\.(\d{2})\.png$/)

  class << self
    def find_in_dir(dir_name)
      files = Dir.glob('*.png', base: dir_name)
      files.select { |file| FILES.match(file) }
    end

    def new_name(file_name)
      return nil unless (match = FILES.match(file_name))

      "#{match[1]}-#{match[2]}-#{match[3]} #{match[4]}.#{match[5]}.#{match[6]}.png"
    end
  end
end
