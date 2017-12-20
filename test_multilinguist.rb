require 'minitest/autorun'
require 'minitest/pride'
require './multilinguist.rb'

class TestMultilinguist < MiniTest::Test

  def setup
    @guy = Multilinguist.new
  end

  def test_initial_language
    assert_equal 'en', @guy.current_lang
  end

  def test_initial_language
    refute_equal 'fr', @guy.current_lang
  end

  def test_language_in_true
    assert_equal 'zh', @guy.language_in("china")
  end

  def test_language_in_false
    refute_equal 'en', @guy.language_in('china')
  end


end
