require_relative 'SKI'
class LCVariable < Struct.new(:name) 
  def to_s 
    name.to_s
  end

  def inspect
    to_s 
  end
  
  def replace(name, replacement) 
    if self.name == name 
      replacement
    else 
      self 
    end
  end

  def callable? 
    false
  end

  def reducible? 
    false
  end

  def to_ski 
    SKISymbol.new(name)
  end
end

class LCFunction < Struct.new(:parameter, :body) 
  def to_s 
    "-> #{parameter} { #{body} }"
  end

  def inspect 
    to_s
  end 

  def replace(name, replacement) 
    if parameter == name 
      self
    else 
      LCFunction.new(parameter, body.replace(name, replacement)) 
    end
  end

  def call(argument) 
    body.replace(parameter, argument)
  end

  def callable? 
    true
  end

  def reducible? 
    false
  end
  
  def to_ski 
    body.to_ski.as_a_function_of(parameter)
  end
end

class LCCall < Struct.new(:left, :right) 
  def to_s
    "#{left}[#{right}]" 
  end

  def inspect 
    to_s
  end

  def replace(name, replacement) 
    LCCall.new(left.replace(name, replacement), right.replace(name, replacement))
  end
  
  def callable? 
    false
  end

  def reducible? 
    left.reducible? || right.reducible? || left.callable?
  end

  def reduce 
    if left.reducible? 
      LCCall.new(left.reduce, right)
    elsif right.reducible? 
      LCCall.new(left, right.reduce)
    else 
      left.call(right) 
    end
  end

  def to_ski 
    SKICall.new(left.to_ski, right.to_ski)
  end
end

TAPE = -> l { -> m { -> r { -> b { PAIR[PAIR[l][m]][PAIR[r][b]] } } } }
TAPE_LEFT = -> t { LEFT[LEFT[t]] } 
TAPE_MIDDLE = -> t { RIGHT[LEFT[t]] } 
TAPE_RIGHT = -> t { LEFT[RIGHT[t]] }
TAPE_BLANK = -> t { RIGHT[RIGHT[t]] }
TAPE_WRITE = -> t { -> c { TAPE[TAPE_LEFT[t]][c][TAPE_RIGHT[t]][TAPE_BLANK[t]] } }

TAPE_MOVE_HEAD_RIGHT = 
  -> t { 
    TAPE[ 
      PUSH[TAPE_LEFT[t]][TAPE_MIDDLE[t]]
    ][
      IF[IS_EMPTY[TAPE_RIGHT[t]]][
        TAPE_BLANK[t]
      ][
        FIRST[TAPE_RIGHT[t]]
      ]
    ][
      IF[IS_EMPTY[TAPE_RIGHT[t]]][
        EMPTY
      ][
        REST[TAPE_RIGHT[t]]
      ]
    ][
      TAPE_BLANK[t]
    ]
  }