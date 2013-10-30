require './roman_number'
require 'test/unit'
class TestRoman < Test::Unit::TestCase
  def test_single_roman_number
    assert_equal RomanNumber.new('I').to_integer, 1
    assert_equal RomanNumber.new('V').to_integer, 5
    assert_equal RomanNumber.new('X').to_integer, 10
    assert_equal RomanNumber.new('L').to_integer, 50
    assert_equal RomanNumber.new('C').to_integer, 100
    assert_equal RomanNumber.new('D').to_integer, 500
    assert_equal RomanNumber.new('M').to_integer, 1000
  end
  
  def test_multiple_identical
    assert_equal RomanNumber.new('II').to_integer, 2
    assert_equal RomanNumber.new('III').to_integer, 3
    assert_equal RomanNumber.new('XX').to_integer, 20
    assert_equal RomanNumber.new('CC').to_integer, 200
    assert_equal RomanNumber.new('MMM').to_integer, 3000
  end

  def test_multiple_different
    assert_equal RomanNumber.new('IV').to_integer, 4
    assert_equal RomanNumber.new('XXXI').to_integer, 31
    assert_equal RomanNumber.new('MCMXCVIII').to_integer, 1998
    assert_equal RomanNumber.new('MMMDCCCLXXXVIII').to_integer, 3888
  end

  def test_invalid
    assert_raise(NotValidRomanNumber, 'String is not a valid roman number') do
      RomanNumber.new('232').to_integer
    end
    assert_raise(NotValidRomanNumber, 'String is not a valid roman number') do
      RomanNumber.new('KJHDHKDH').to_integer
    end
    assert_raise(NotValidRomanNumber, 'String is not a valid roman number') do 
      RomanNumber.new('MMMMMM').to_integer
    end
    assert_raise(NotValidRomanNumber, 'String is not a valid roman number') do
      RomanNumber.new('IIIII').to_integer
    end
  end

end