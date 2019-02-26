require 'csv'
require 'set'

class Adjective
  attr_reader :number, :first_letter

  def initialize(number, first_letter, word)
    @number = number
    @first_letter = first_letter
    @word = word
  end

  def to_s
    @word
  end
end

class Noun
  attr_reader :number

  def initialize(number, word)
    @number = number
    @word = word
  end

  def to_s
    @word
  end
end

def create_class_phrase(all_adjective_count, all_noun_count)

  Class.new do
    attr_reader :adjective, :noun

    def initialize(args)
      @adjective = args[:adjective]
      @noun = args[:noun]
    end

    def to_s
      @adjective.to_s + @noun.to_s
    end

    def first_letter
      @adjective.first_letter
    end

    define_method :hash do
      all_adjective_count * @noun.number + @adjective.number
    end

    def eql?(other)
      self.adjective.number == other.adjective.number &&
      self.noun.number == other.noun.number
    end
  end

end

# Load.
adjectives = CSV.foreach('./adjective.csv').map do |row|
  Adjective.new(row[0].to_i, row[1], row[2])
end
nouns = CSV.foreach('./noun.csv').map do |row|
  Noun.new(row[0].to_i, row[1])
end

Phrase = create_class_phrase(adjectives.length, nouns.length)

phrases = nouns.product(adjectives).map do |noun, adjective|
  Phrase.new(adjective: adjective, noun: noun)
end

puts '---Vocabulary---'
phrases.each { |phrase| puts "#{phrase.hash}:#{phrase}"}
puts

# Shiritori.
my_past_answers = Set.new
puts "Enter 'q' when you want to quit."

while(true) do
  puts 'Enter your word.'

  got_answer = gets.chomp
  if got_answer == 'q'
    puts 'Bye.'
    return
  end

  first_letter = got_answer[-1]
  my_answer = phrases.find do |phrase|
    phrase.first_letter == first_letter && my_past_answers.add?(phrase)
  end

  if my_answer
    puts "My Answer: #{my_answer}"
  else
    puts "I give up! Bye!"
    return
  end
end
