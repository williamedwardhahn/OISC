# OISC Code
[MPCR OISC](https://colab.research.google.com/drive/1iaxUqTnE7hOe7Ni4hXlcppskNG3gC0sp?usp=sharing)


# OISC
This code is a custom implementation of a One Instruction Set Computer (OISC) with a virtual machine that has a single native instruction: copy-paste. The code uses a custom stack-based programming language called 'code.ai', which is similar to the Forth programming language. The purpose of this language is to perform arithmetic operations and manipulate data using a simple stack-based system.


# Stack-based languages and OISC
A stack-based language is a type of programming language that uses a stack data structure to store and manipulate data. A stack is a Last In, First Out (LIFO) data structure, meaning that the most recently added item is the first one to be removed. In a stack-based language, operands are pushed onto the stack, and operations are performed by popping operands from the stack, processing them, and then pushing the result back onto the stack.

The main advantage of stack-based languages is their simplicity, as they often have a small number of instructions and can be easily implemented in hardware or software. Examples of stack-based languages include Forth, PostScript, and the custom 'code.ai' language implemented in this code.

# One Instruction Set Computer (OISC)
An OISC is a theoretical computer architecture that has only one native instruction. The goal of OISC is to simplify the design and implementation of a computer system. In this implementation, the single native instruction is copy-paste, which copies a value from one memory location to another. All other operations are memory-mapped, meaning that they are implemented by writing to or reading from specific memory addresses.

# The 'code.ai' language and its implementation
The 'code.ai' language is a custom stack-based language inspired by Forth. Each word in the language is a subroutine that is called using the machine code "#,W", where "#" is a placeholder for the word that is looked up in the dictionary D to get the location in memory where the subroutine machine code is located. The compiler builds a threaded interpreted language style program that is loaded on the memory tape M and then executed. This is an example of subroutine threading.

## The main components of the code include:
* Loading the 'code.ai' language definitions from a file.
* Defining helper functions for dictionary lookups, code recoding, and setting up the memory tape.
Compiling a given program into a series of instructions and operands.
Executing the program using the custom virtual machine.
Loading the language definitions
The code begins by loading the 'code.ai' language definitions from a file named 'code.ai'. The load function reads the file line by line and stores the words and their corresponding machine codes into two NumPy arrays, words and codes.

## Helper functions
The code defines several helper functions:

##D(word): A dictionary lookup function that returns the index of the given word in the words array, or -1 if the word is not found.
recode(codes): A function that recodes the given codes by replacing each word with its corresponding index in the words array.
setup(program): A function that sets up the memory tape M by initializing it with the compiled 'code.ai' language and the given program.
compile_program(X): A function that compiles a given program X into a series of instructions and operands, suitable for execution by the virtual machine.

# Compiling the program
The compile_program(X) function takes a program X written in the 'code.ai' language and converts it into a sequence of instructions and operands that the virtual machine can execute. The function iterates through each element of the program, checks if it is a number, a comma-separated pair, or a word from the language, and then appends the corresponding machine codes to the compiled program.

# Executing the program
The run(M) function takes the memory tape M as input and executes the program using the custom virtual machine. The function implements the single native instruction (copy-paste) and several memory-mapped operations, such as addition, subtraction, multiplication, and division. It uses a while loop to iterate through the instructions in the memory tape, updating the instruction pointer IP and the memory locations according to the specified rules.

The virtual machine maintains two stacks: one for parameters (S) at location SL, and another for return addresses (W) at location WL. The copy-paste instruction is used to move values between memory locations, push and pop values to and from the stacks, and perform subroutine calls and returns.

# Threading and the simplicity of the compiler
Subroutine threading
The 'code.ai' language uses subroutine threading, which means that each word in the language is treated as a subroutine (i.e., a sequence of instructions and operands that perform a specific task). When a word is called, the virtual machine jumps to the memory location where the subroutine's machine code is stored and begins executing it. The return address is pushed onto the return address stack (W) before the jump, and it is popped when the subroutine finishes executing, allowing the virtual machine to return to the original program.

Subroutine threading simplifies the implementation of the language, as the compiler only needs to generate machine codes that call the appropriate subroutines for each word in the program.

# Postfix notation and the simplicity of the compiler
The 'code.ai' language uses postfix notation, also known as Reverse Polish Notation (RPN), which is a mathematical notation where operators follow their operands. In postfix notation, there is no need for parentheses to indicate the order of operations, and the notation naturally corresponds to the stack-based execution model of the virtual machine.

The simplicity of postfix notation greatly simplifies the compiler for the 'code.ai' language, as there is no need to parse complex expressions or manage operator precedence. The compiler can focus on translating the words in the program into machine codes that manipulate the stacks and perform the desired operations.

In summary, the 'code.ai' language implementation demonstrates how a simple stack-based language with a single native instruction can be used to perform complex operations using subroutine threading, postfix notation, and a straightforward compiler. This implementation serves as a useful introduction to stack-based languages and the OISC concept for beginners in programming.


## Reading List
[Starting Forth](https://github.com/williamedwardhahn/OISC/blob/main/Forth_Books/Starting%20FORTH%20Introduction%20to%20the%20FORTH%20Language%20and%20Operating%20System%20for%20Beginners%20and%20Professionals%20(Leo%20Brodie).pdf)

[Thinking Forth](https://github.com/williamedwardhahn/OISC/blob/main/Forth_Books/Thinking%20Forth%20A%20Language%20and%20Philosophy%20for%20Solving%20Problems%20(Leo%20Brodie).pdf)

[More Books](https://github.com/williamedwardhahn/OISC/tree/main/Forth_Books)


### Notes

http://www.ultratechnology.com/

http://www.faqs.org/faqs/computer-lang/forth-faq/part5/

http://mind.sourceforge.net/aisteps.html#alife

http://testra.com/Forth/VHDL.htm

https://learnxinyminutes.com/docs/forth/

https://asciiflow.com/#/

http://www.murphywong.net/hello/simple.htm


http://galileo.phys.virginia.edu/classes/551.jvn.fall01/primer.htm

https://archive.org/details/R.G.LoeligerThreadedInterpretiveLanguagesTheirDesignAndImplementationByteBooks1981/page/n7/mode/2up?view=theater


http://www.forth.org/eforth.html


http://www.figuk.plus.com/articles/chuck.pdf
