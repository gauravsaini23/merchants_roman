class RomanNumber
  ROMAN_NUMBER = { I: 1,
                   V: 5,
                   X: 10,
                   L: 50,
                   C: 100,
                   D: 500,
                   M: 1000 }
  
  def initialize(roman)
    @roman = roman
    fail(NotValidRomanNumber, 'String is not a valid roman number') unless valid?
    @syms = @roman.split('').collect(&:to_sym)
  end
  
  def valid?
    @roman =~ /^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/
  end
  
  def to_integer
    total = 0
    @syms.each_with_index do |sym, index|
      @current_sym = sym
      @index = index
      if sym != @syms.last && next_number_greater?
        total -= convert_to_integer
      else
        total += convert_to_integer
      end
    end
    total
  end
  
  private
  #converts the single roman symbol to integer
  def convert_to_integer(sym = @current_sym)
    ROMAN_NUMBER[sym]
  end

  def next_number_greater?(index=@index)
    @grtr = convert_to_integer < convert_to_integer(next_symbol(index))
  end
  
  def next_symbol(index)
    @syms[index + 1]
  end
end

class NotValidRomanNumber < StandardError; end
