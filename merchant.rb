require './roman_number'
class Merchant
  def initialize(lines)
    @lines = lines
    @roman_map = {}
    @metal_map = {}
  end
  @val_map
  def to_galactic_output
    out_lines = @lines.map do |line|
      @current = line
      begin
        output = parse_sentence
        output unless output.nil?
      rescue WrongInput => e
        "I have no idea what you are talking about"
      end
    end
    out_lines.compact
  end
  private
  def parse_sentence(sentence = @current)
    if(que = sentence_is_question)
      prob = sentence.gsub(/(#{que})/, "").gsub(/( \?)/, "")
      roman = ""
      capital = nil
      prob.split(" ").map do |literal|
        capital = nil
        if first_letter_capital?(literal)
          capital = literal
          break
        else
          roman += @roman_map[literal.to_sym]
        end
      end
      if capital.nil?
        prob + " is #{RomanNumber.new(roman).to_integer}"
      else
        prob + " is #{RomanNumber.new(roman).to_integer * @metal_map[capital.to_sym]} credits"
      end
    else
      arr = sentence.split(" is ")
      if arr.size > 1
        vars = arr[0].split(" ")
        if vars.size == 1
          @roman_map[vars[0].to_sym] = arr[1]
        else
          vars.each do |v|
            if first_letter_capital?(v) #if its a capital letter pick value from @roman_map and calculate the metal value using it
              calculate_metal_value(vars - [v], v, arr[1])
            else
            end
          end
        end
        return nil
      else
        fail(WrongInput, "Sentence is not in a valid format." )
      end
    end
  end
  
  def first_letter_capital?(v)
    m = v.match(/^[A-Z]/)
    m != nil
  end
  
  def sentence_is_question
    m = @current.match(/^(how much is )|(how many Credits is )/)
    m ? (m.to_s) : false
  end
  
  def calculate_metal_value(literals, metal, total_value)
    roman = ""
    literals.map{|l| @roman_map[l.to_sym] ? roman += @roman_map[l.to_sym] : fail(WrongInput, "Value not provided for '#{l}'" )}
    roman_val = RomanNumber.new(roman).to_integer
    @metal_map[metal.to_sym] = (total_value.to_i/roman_val)
  end
end

class WrongInput < StandardError; end
if ARGV[0].nil?
  puts "Please provide the input file."
else
  lines = IO.readlines("#{ARGV[0]}").map{|l| l.chomp}
  merchant = Merchant.new(lines)
  puts merchant.to_galactic_output.inspect
  merchant.to_galactic_output.each {|line| puts line}
end