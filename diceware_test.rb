# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'diceware'

class DicewareTest < Minitest::Test
  DICTIONARY = CSV.read('./eff_large_wordlist.txt').to_h

  def test_it_rolls_5_dice
    actual = Diceware.roll
    assert_equal 5, actual.length
    actual.each do |roll|
      assert [1, 2, 3, 4, 5, 6].include?(roll)
    end
  end

  def test_it_returns_a_word
    actual = Diceware.word
    assert DICTIONARY.values.include? actual
  end

  def test_it_returns_a_phrase
    actual = Diceware.phrase(6)
    words = actual.split
    assert_equal 6, words.length
    words.each do |word|
      assert DICTIONARY.values.include? word
    end
  end

  def test_it_returns_a_four_word_phrase
    actual = Diceware.phrase(4)
    words = actual.split
    assert_equal 4, words.length
  end
end
