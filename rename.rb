#!/usr/bin/env ruby

require 'minitest'

require_relative './screenshot'

class ScreenshotTest < MiniTest::Test
  def test_find_files_none
    result = Screenshot.find_in_dir(File.expand_path('fixtures/already-renamed', __dir__))

    assert_equal [], result
  end

  def test_find_files_some
    result = Screenshot.find_in_dir(File.expand_path('fixtures/some-renamed', __dir__))

    assert_equal ['Screenshot 2020-04-24 10.42.36(2).png', 'Screen Shot 2021-05-22 at 2.16.30 PM.png'], result
  end

  def test_new_name_new_pm
    assert_equal '2021-04-19 14.12.27.png', Screenshot.new_name('Screen Shot 2021-04-19 at 2.12.27 PM.png')
  end

  def test_new_name_new_noonish
    assert_equal '2021-04-19 12.12.27.png', Screenshot.new_name('Screen Shot 2021-04-19 at 12.12.27 PM.png')
  end

  def test_new_name_new_am
    assert_equal '2021-04-05 11.33.36.png', Screenshot.new_name('Screen Shot 2021-04-05 at 11.33.36 AM.png')
  end

  def test_new_name_new_multiple
    assert_equal '2020-08-27 11.45.06 (2).png', Screenshot.new_name('Screen Shot 2020-08-27 at 11.45.06 AM (2).png')
  end

  def test_new_name_old
    assert_equal '2020-07-20 15.44.48.png', Screenshot.new_name('Screenshot 2020-07-20 15.44.48.png')
  end

  def test_new_name_old_am
    assert_equal '2020-07-31 08.46.00.png', Screenshot.new_name('Screenshot 2020-07-31 08.46.00.png')
  end

  def test_new_name_old_multiple
    assert_equal '2020-04-24 10.42.36 (2).png', Screenshot.new_name('Screenshot 2020-04-24 10.42.36(2).png')
  end
end

if MiniTest.run
  Screenshot.run(File.expand_path('~/Desktop'))
else
  puts 'Tests failed'
  puts 'No real files processed'
end
