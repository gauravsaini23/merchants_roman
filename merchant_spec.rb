require './merchant'
require 'test/unit'
class TestMerchant < Test::Unit::TestCase
  LINES1 = 
  def test_unit
    assert_equal Merchant.new(["glob is I"]).to_galactic_output, []
    assert_equal Merchant.new(["glob is I", "glob glob Silver is 34 Credits"]).to_galactic_output, []
  end
  
  def test_functional
    input_arr = ["glob is I", 
           "prok is V", 
           "pish is X",
           "tegj is L",
           "glob glob Silver is 34 Credits","glob prok Gold is 57800 Credits",
           "pish pish Iron is 3910 Credits",
           "how much is pish tegj glob glob ?", 
           "how many Credits is pish prok Silver ?", 
           "how many Credits is pish prok Gold ?", 
           "how many Credits is pish prok Iron ?"]
    output_arr = ["pish tegj glob glob is 42", 
                  "pish prok Silver is 255 credits", 
                  "pish prok Gold is 216750 credits", 
                  "pish prok Iron is 2925 credits"]
    assert_equal Merchant.new(input_arr).to_galactic_output, output_arr
  end

  def test_invalid
    assert_equal Merchant.new(["Something that does not mean anything in galaxies"]).to_galactic_output, ["I have no idea what you are talking about"]
  end

end
