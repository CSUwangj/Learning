require_relative 'tag_rule'
require_relative 'cyclic_tag_system'

class TagRule
  def to_cyclic(encoder) 
    CyclicTagRule.new(encoder.encode_string(append_characters))
  end
end

class TagRulebook < Struct.new(:deletion_number, :rules) 
  def next_string(string) 
    rule_for(string).follow(string).slice(deletion_number..-1)
  end

  def rule_for(string) 
    rules.detect { |r| r.applies_to?(string) }
  end 

  def applies_to?(string) 
    !rule_for(string).nil? && string.length >= deletion_number
  end

  def alphabet 
    rules.flat_map(&:alphabet).uniq
  end

  def cyclic_rules(encoder) 
    encoder.alphabet.map { |character| cyclic_rule_for(character, encoder) }
  end

  def cyclic_rule_for(character, encoder) 
    rule = rule_for(character)
    if rule.nil? 
      CyclicTagRule.new('')
    else 
      rule.to_cyclic(encoder) 
    end
  end

  def cyclic_padding_rules(encoder) 
    Array.new(encoder.alphabet.length, CyclicTagRule.new('')) * (deletion_number - 1)
  end

  def to_cyclic(encoder) 
    CyclicTagRulebook.new(cyclic_rules(encoder) + cyclic_padding_rules(encoder))
  end
end

class TagSystem < Struct.new(:current_string, :rulebook) 
  def step 
    self.current_string = rulebook.next_string(current_string)
  end

  def run 
    while rulebook.applies_to?(current_string) 
      puts current_string 
      step
    end 

    puts current_string
  end

  def alphabet 
    (rulebook.alphabet + current_string.chars.entries).uniq.sort
  end

  def encoder
    CyclicTagEncoder.new(alphabet) 
  end

  def to_cyclic 
    TagSystem.new(encoder.encode_string(current_string), rulebook.to_cyclic(encoder))
  end
end

class CyclicTagEncoder < Struct.new(:alphabet)
  def encode_string(string) 
    string.chars.map { |character| encode_character(character) }.join
  end

  def encode_character(character)
    character_position = alphabet.index(character) 
    (0...alphabet.length).map { |n| n == character_position ? '1' : '0' }.join
  end 
end