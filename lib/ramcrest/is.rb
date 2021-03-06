require 'ramcrest/match'

module Ramcrest
  module Is
    def self.to_matcher(possible_matcher)
      return possible_matcher if Ramcrest.is_matcher?(possible_matcher)
      Ramcrest::Is.is(possible_matcher)
    end

  module_function

    def is(expected)
      Matcher.new(Ramcrest::EqualTo.to_matcher(expected))
    end

    class Matcher
      include Ramcrest::Match

      def initialize(expected)
        @expected = expected
      end

      def matches?(actual)
        match = @expected.matches?(actual)
        if match.matched?
          success
        else
          mismatch("was <#{match.description}>")
        end
      end

      def description
        "is <#{@expected.description}>"
      end
    end
  end
end
