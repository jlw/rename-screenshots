#!/usr/bin/env ruby

require 'minitest'

require_relative './screenshot_cleanshot'

class ScreenshotCleanshotTest < MiniTest::Test
  def test_find_files_none
    result = ScreenshotCleanshot.find_in_dir(File.expand_path('fixtures/already-renamed', __dir__))

    assert_equal [], result
  end

  def test_find_files_some
    result = ScreenshotCleanshot.find_in_dir(File.expand_path('fixtures/some-renamed', __dir__))

    assert_equal ['CleanShot 2023-05-27 at 12.16.30.png'], result
  end

  def test_new_name_old
    assert_equal '2020-07-20 15.44.48.png', ScreenshotCleanshot.new_name('CleanShot 2020-07-20 at 15.44.48.png')
  end

  def test_retina_files
    assert_equal '2020-07-20 15.44.48.png', ScreenshotCleanshot.new_name('CleanShot 2020-07-20 at 15.44.48@2x.png')
  end
end

if MiniTest.run
  ScreenshotCleanshot.run(File.expand_path('~/Desktop'))
else
  puts 'Tests failed'
  puts 'No real files processed'
end
