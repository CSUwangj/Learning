class TagRule < Struct.new(:first_character, :append_characters) 
  def applies_to?(string) 
    string.chars.first == first_character
  end
  
  def follow(string) 
    string + append_characters
  end
  
  def alphabet 
    ([first_character] + append_characters.chars.entries).uniq
  end
end