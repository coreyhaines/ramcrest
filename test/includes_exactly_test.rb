require 'minitest/autorun'
require 'ramcrest'

describe Ramcrest::IncludesExactly do
  include Ramcrest::MatcherMatcher
  include Ramcrest::Is
  include Ramcrest::IncludesExactly

  it "matches enumerables that have all of the elements in order" do
    assert_that includes_exactly(is(1), is(2)), a_matcher_that_matches([1, 2])
  end

  it "coerces values into equality matches" do
    assert_that includes_exactly(1, 2), a_matcher_that_matches([1, 2])
  end

  it "does not match when the elements are out of order" do
    assert_that includes_exactly(is(1), is(2)),
      a_matcher_that_mismatches([2, 1], "an enumerable of [2, 1]")
  end

  it "does not match when there are fewer elements than expected" do
    assert_that includes_exactly(is(1), is(2)),
      a_matcher_that_mismatches([1], "an enumerable of [1] which is the wrong size")
  end

  it "does not match when there are more elements than expected" do
    assert_that includes_exactly(is(1), is(2)),
      a_matcher_that_mismatches([1, 2, 3], "an enumerable of [1, 2, 3] which is the wrong size")
  end

  it "describes itself" do
    assert_that includes_exactly(is(1), is(2)),
      a_matcher_described_as("an enumerable including exactly [is <1>, is <2>]")
  end
end