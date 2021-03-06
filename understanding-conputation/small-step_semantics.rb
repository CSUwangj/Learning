class Literal < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    false
  end
end


class Number < Literal
end


class Boolean < Literal
end


class BinaryOperator < Struct.new(:left, :right)
  def to_s
    raise "Not implement yet!!!"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce_helper
    raise "Not implement yet!!!"
  end

  def reduce(environment)
    if left.reducible?
      self.class.new(left.reduce(environment), right)
    elsif right.reducible?
      self.class.new(left, right.reduce(environment))
    else
      reduce_helper
    end
  end
end


class Add < BinaryOperator
  def to_s
    "#{left} + #{right}"
  end

  def reduce_helper
    Number.new(left.value + right.value)
  end
end

class Multiply < BinaryOperator
  def to_s
    "#{left} * #{right}"
  end

  def reduce_helper
    Number.new(left.value * right.value)
  end
end

class LessThan < BinaryOperator
  def to_s
    "#{left} < #{right}"
  end

  def reduce_helper
    Boolean.new(left.value < right.value)
  end
end


class Variable < Struct.new(:name)
  def to_s
    name.to_s
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    environment[name]
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

  def reducible?
    false
  end
end


class Assign < BinaryOperator
  # left is name, right is expression
  def to_s
    "#{left} = #{right}"
  end


  def reduce(environment)
    if right.reducible?
      [Assign.new(left, right.reduce(environment)), environment]
    else
      [Stop.new, environment.merge({left => right})]
    end
  end
end


class Machine < Struct.new(:statement, :environment)
  def step
    self.statement, self.environment = statement.reduce(environment)
  end
  
  def run
    while statement.reducible? 
      puts "#{statement}, #{environment}" 
      step
    end
    puts "#{statement}, #{environment}"
  end
end


class If < Struct.new(:condition, :consequence, :alternative)
  def to_s
    "if (#{condition}) { #{consequence} } else { #{alternative} }"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    if condition.reducible?
      [If.new(condition.reduce(environment), consequence, alternative), environment]
    else
      case condition
      when Boolean.new(true)
        [consequence, environment]
      when Boolean.new(false)
        [alternative, environment]
      end
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

  def reducible?
    true
  end

  def reduce(environment)
    case first
    when Stop.new
      if successors.length == 0
        [Stop.new, environment]
      else
        [Sequence.new(successors[0], successors.slice(1, successors.length)), environment]
      end
    else
      reduced_first, reduced_environment = first.reduce(environment)
      [Sequence.new(reduced_first, successors), reduced_environment]
    end
  end   
end


class While < Struct.new(:condition, :consequence)
  def to_s
    "while (#{condition}) { #{consequence} }"
  end

  def inspect
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    [If.new(
      condition, 
      Sequence.new(
        consequence, 
        [self]),
      Stop.new), 
    environment]
  end
end 

        
Machine.new(
  While.new(
    LessThan.new(
      Variable.new(:y), 
      Number.new(5)),
    Sequence.new(
      Assign.new(:x, 
        Multiply.new(
          Variable.new(:x), 
          Number.new(3)
      )),
      [Assign.new(:y, 
        Add.new(
          Variable.new(:y), 
          Number.new(1)
  ))])),
  { x: Number.new(1), y: Number.new(1) }
).run
