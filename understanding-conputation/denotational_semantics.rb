class Literal < Struct.new(:value)
  def to_ruby
    "-> e { #{value.inspect} }"
  end
end



class Number < Literal
end

class Boolean
end

class BinaryOperator < Struct.new(:left, :right)
  def to_ruby
    "-> e { (#{left.to_ruby}).call(e) " + helper() + " (#{right.to_ruby}).call(e) }"
  end

  def helper
    raise "Not implement yet!!!"
  end
end

class Add < BinaryOperator
  def helper
    "+"
  end
end

class Multiply < BinaryOperator
  def helper
    "*"
  end
end

class LessThan < BinaryOperator
  def helper
    "<"
  end
end

class Variable < Struct.new(:name)
  def to_ruby
    "-> e { e[#{name.inspect}] }"
  end
end

class Assign < BinaryOperator
  def to_ruby
    "-> e { e.merge({ #{left.inspect} => (#{right.to_ruby}).call(e) }) }"
  end
end

class Stop
  def to_ruby
    "-> e{ e }"
  end
end


class If < Struct.new(:condition, :consequence, :alternative)
  def to_ruby
    "-> e {if (#{condition.to_ruby}).call(e)" +
      "then (#{consequence.to_ruby}).call(e)" +
      "else (#{alternative.to_ruby}).call(e)" +
      "end }"
  end 
end


class Sequence < Struct.new(:first, :successors)
  def to_ruby
    s = "(#{first.to_ruby}).call(e)"
    successors.each{|x| s = "#{x.to_ruby}).call(" + s + ")"}
    s = "-> e { " + s + " }"
    s
  end 
end


class While < Struct.new(:condition, :consequence)
  def to_ruby
    "-> e {" +
      " while (#{condition.to_ruby}).call(e); e = (#{consequence.to_ruby}).call(e); end;" +
      " e" +
      "}"
  end
end 
