class Literal < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    self
  end
end


class Number < Literal
end


class Boolean < Literal
end


class Variable < Struct.new(:name)
  def to_s
    name.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    environment[name]
  end
end


class BinaryOperator < Struct.new(:left, :right)
  def to_s
    raise "Not implement yet!!!"
  end

  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    raise "Not implement yet!!!"
  end
end


class Add < BinaryOperator
  def to_s
    "#{left} + #{right}"
  end

  def evaluate(environment)
    Number.new(left.evaluate(environment).value + right.evaluate(environment).value)
  end
end

class Multiply < BinaryOperator
  def to_s
    "#{left} * #{right}"
  end

  def evaluate(environment)
    Number.new(left.evaluate(environment).value * right.evaluate(environment).value)
  end
end

class LessThan < BinaryOperator
  def to_s
    "#{left} < #{right}"
  end

  def evaluate(environment)
    Boolean.new(left.evaluate(environment).value < right.evaluate(environment).value)
  end
end


class Assign < BinaryOperator
  # left is name, right is expression
  def to_s
    "#{left} = #{right}"
  end

  def evaluate(environment)
    environment.merge({left => right.evaluate(environment)})
  end
end


class Stop
  def to_s
    ';'
  end

  def inspect
    "<<#{self}>>"
  end

  def ==(other)
    other.instance_of?(Stop)
  end

  def evaluate(environment)
    environment
  end
end


class If < Struct.new(:condition, :consequence, :alternative)
  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      consequence.evaluate(environment)
    when Boolean.new(false)
      alternative.evaluate(environment)
    end
  end
end


class Sequence < Struct.new(:first, :successors)
  def to_s
    s = "#{first};"
    successors.each{ |x| s += " #{x};"}
    s
  end

  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    new_env = first.evaluate(environment)
    successors.each{|x| new_env = x.evaluate(new_env)}
    new_env
  end
end


class While < Struct.new(:condition, :consequence)
  def to_s
    "while (#{condition}) { #{consequence} }"
  end

  def inspect
    "<<#{self}>>"
  end

  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      evaluate(consequence.evaluate(environment))
    when Boolean.new(false)
      environment
    end
  end
end 


statement = Sequence.new( 
  Assign.new(:x, Add.new(Number.new(1), Number.new(1))), 
  [Assign.new(:y, Add.new(Variable.new(:x), Number.new(3)))]
)

statement.evaluate({})