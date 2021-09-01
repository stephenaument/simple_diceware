# frozen_string_literal: true

require 'csv'

DEFAULT_PHRASE_LENGTH = 8

class Diceware
  DICTIONARY = CSV.read('./eff_large_wordlist.txt').to_h
  DIE_COUNT = 5
  DIE_FACES = [1, 2, 3, 4, 5, 6].freeze

  class << self
    def roll_one
      DIE_FACES.sample
    end

    def roll
      Array.new(DIE_COUNT)
           .map { roll_one }
    end

    def phrase(word_count)
      Array.new(word_count)
           .map { word }
           .join(' ')
    end

    def word
      key = roll.join
      DICTIONARY[key]
    end
  end
end

if %w(help h).include? ARGV.first.to_s
  puts 'This script generates a diceware passphrase using the eff'
  puts 'large wordlist.'
  puts
  puts '  Usage: $> diceware <length> # default length is 8'
  puts
  puts '  Examples:'
  puts '    $> diceware'
  puts '    depletion spinal financial vixen rearrange hazing outdoors imprecise'
  puts
  puts '    $> diceware 4'
  puts '    unweave nurture fetal twilight'
  exit 0
end

word_count = ARGV.first || DEFAULT_PHRASE_LENGTH

puts Diceware.phrase(word_count.to_i)
