# Understanding Computation

## the meaning of programs

> And this is what operational semantics really is: explaining the meaning of a language by describing an interpreter.
---
> **Comparing Semantic Styles**
> «while» is a good example of the difference between small-step, big-step, and denotational semantics.
> The small-step operational semantics of «while» is written as a reduction rule for an abstract machine. The overall looping behavior isn’t part of the rule’s action—reduction just turns a «while» statement into an «if» statement—but it emerges as a consequence of the future reductions performed by the machine. To understand what «while» does, we need to look at all of the small-step rules and work out how they interact over the course of a SIMPLE program’s execution.
> «while»’s big-step operational semantics is written as an evaluation rule that shows how to compute the final environment directly. The rule contains a recursive call to itself, so there’s an explicit indication that «while» will cause a loop during evaluation, but it’s not quite the kind of loop that a SIMPLE programmer would recognize. Big-step rules are written in a recursive style, describing the complete evaluation of an expression or statement in terms of the evaluation of other pieces of syntax, so this rule tells us that the result of evaluating a «while» statement may depend upon the result of evaluating the same statement in a different environment, but it requires a leap of intuition to connect this idea with the iterative behavior that «while» is supposed to exhibit. Fortunately the leap isn’t too large: a bit of mathematical reasoning can show that the two kinds of loop are equivalent in principle, and when the metalanguage supports tail call optimization, they’re also equivalent in practice.
> The denotational semantics of «while» shows how to rewrite it in Ruby, namely by using Ruby’s while keyword. This is a much more direct translation: Ruby has native support for iterative loops, and the denotation rule shows that «while» can be implemented with that feature. There’s no leap required to understand how the two kinds of loop relate to each other, so if we understand how Ruby while loops work, we understand SIMPLE «while» loops too. Of course, this means we’ve just converted the problem of understanding SIMPLE into the problem of understanding the denotation language, which is a serious disadvantage when that language is as large and ill-specified as Ruby, but it becomes an advantage when we have a small mathematical languagefor writing denotations.
---
> We saw earlier that operational semantics is about explaining a language’s meaning by designing an interpreter for it. By contrast, the language-to-language translation of denotational semantics is like a compiler: in this case, our implementations of #to_ruby effectively compile SIMPLE into Ruby. None of these styles of semantics necessarily says anything about how to efficiently implement an interpreter or compiler for a language, but they do provide an official baseline against which the correctness of any efficient implementation can be judged.
---
> The semantic styles seen in this chapter go by many different names. Small-step semantics is also known as structural operational semantics and transition semantics; big-step semantics is more often called natural semantics or relational semantics; and denotational semantics is also called fixed-point semantics or mathematical semantics.
>
> Other styles of formal semantics are available. One alternative is axiomatic semantics, which describes the meaning of a statement by making assertions about the state of the abstract machine before and after that statement executes: if one assertion (the precondition) is initially true before the statement is executed, then the other assertion (the postcondition) will be true afterward. Axiomatic semantics is useful for verifying the correctness of programs: as statements are plugged together to make larger programs, their corresponding assertions can be plugged together to make larger assertions, with the goal of showing that an overall assertion about a program matches up with its intended specification.

## the simplese computers

regular expression -> NFA:

1. Empty get an one-node-NFA, and no rule.
2. Literal get an two-node-NFA, where start at one and end at another, with only one rule.
3. Concatenate starts at the beginning state of the former, ends at the end states of the latter, and turing the former's end states into normal states. Then add rule for each the former's end state, which begin at it and end at the latter's start state.
4. Choose start at a new state, through a free move to both start state. It ends at either end states.
5. Repeat start just add a free move from each end state to start state, and make start state a end state.

NFA -> DFA:

1. Beginning at start state, and explore every free move. All states now became a new state, which is start state of DFA.
2. Find all rules, make every result get by move through one character into a new state, add it into DFA, also the rule.

> DFA Minimization
>
> 1. Begin with your nonminimal DFA. 
> 2. Reverse all of the rules. Visually, this means that every arrow in the machine’s diagram stays in the same place but points backward; in code terms, every FAR ule.new(state, character, next_state) is replaced with FARule.new(next_state, character, state). Reversing the rules usually breaks the determinism constraints, so now you have an NFA.
> 3. Exchange the roles of start and accept states: the start state becomes an accept state, and each of the accept states becomes a start state. (You can’t directly convert all the accept states into start states because an NFA can only have one start state, but you can get the same effect by creating a new start state and connecting it to each of the old accept states with a free move.)
> 4. Convert this reversed NFA to a DFA in the usual way.
