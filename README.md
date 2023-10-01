## MPCR OISC - One Instruction Set Computer
[MPCR OISC Code Here](https://colab.research.google.com/drive/1JP9zaq6ZKrIG2V8dFxc2Cjq6v1abyb4E?usp=sharing)


# One Instruction Set Computer (OISC) Emulator

## Introduction
In the modern era of computing, systems have grown increasingly complex, often built upon layers of abstractions with millions of lines of code. This complexity can lead to inefficiencies, vulnerabilities, and a steep learning curve for budding developers. The One Instruction Set Computer (OISC) Emulator aims to counter this trend by simplifying the essence of computing to its fundamental core, reducing what might take hundreds of millions of lines down to mere hundreds.

## The Complexity of Modern Computing
Modern computing systems, from operating systems to applications, have grown in complexity over the years. Software stacks are constructed upon multiple layers of code, libraries, and frameworks:

- **Operating Systems**: OS like Windows, Linux, or macOS consist of millions of lines of code. They manage hardware, provide services, and serve as platforms for applications.
- **Middleware and Libraries**: Between the OS and the applications, numerous libraries and middleware components handle everything from graphics rendering to database connections.
- **Applications**: Even seemingly simple apps can have thousands to millions of lines of code, especially when considering the frameworks and libraries they are built upon.

While this complexity has allowed for advanced functionalities, richer user experiences, and integration across diverse platforms, it also brings challenges:

- **Security Vulnerabilities**: More code means more potential vulnerabilities. It's challenging to ensure every line of code is secure in vast systems.
- **Maintenance Overhead**: As codebases grow, maintaining them becomes a significant challenge. Bugs are harder to trace, and improvements are more challenging to implement.
- **Learning Curve**: For new developers, understanding a complex system can be daunting. The sheer volume of components, libraries, and dependencies can be overwhelming.

## What is OISC?
OISC stands for One Instruction Set Computer. It's a theoretical computing model that, as the name suggests, operates with a single instruction. The idea behind OISC is to simplify computing's core essence, stripping away layers of abstraction and complexity. In our implementation, the primary instruction is "copy-paste," a simple operation that can be combined in various ways to perform more complex tasks.

## Reducing Complexity with OISC
The OISC emulator provides an environment where the vastness of modern computing is distilled into its purest form. Here are the benefits:

- **Simplicity**: With only one instruction, the architecture is straightforward to understand and work with.
- **Efficiency**: Fewer instructions mean faster execution times and fewer resources used.
- **Transparency**: The reduced complexity makes the entire process transparent. You see the entire process from input to output without layers of abstraction hiding the details.
- **Educational Value**: For those learning about computer architecture, OISC offers a clean slate to understand the foundational principles without the distractions of modern architectures.

## Implementation Details
Our OISC emulator uses the `code.ai` language, a custom stack-based language inspired by Forth:

- **Stack-based**: Operations are performed by manipulating a stack, a LIFO (Last In, First Out) data structure. 
- **Memory-mapped operations**: Operations like addition, subtraction, and multiplication are achieved by reading from or writing to specific memory addresses.
- **Subroutine Threading**: Each word in the language represents a subroutine, making the language extensible and modular.

The provided code offers functions to load programs, compile them, set up the necessary environment, and run them on the OISC emulator.


---

## Getting Started
To get started with the OISC emulator:

1. Clone the repository.
2. Load the `code.ai` definitions by calling the `load` function.
3. Compile your program using the `compile_program` function.
4. Set up the environment using the `setup` function.
5. Run your program on the emulator using the `run` function.

Refer to the provided examples to see the OISC emulator in action.

This code is a custom implementation of a One Instruction Set Computer (OISC) with a virtual machine that has a single native instruction: copy-paste. The code uses a custom stack-based programming language called 'code.ai', which is similar to the Forth programming language.

## One Instruction Set Computer (OISC)
An OISC is a theoretical computer architecture that has only one native instruction. The goal of OISC is to simplify the design and implementation of a computer system. In this implementation, the single native instruction is copy-paste, which copies a value from one memory location to another. All other operations are memory-mapped, meaning that they are implemented by writing to or reading from specific memory addresses.

## Stack-based languages and OISC
A stack-based language is a type of programming language that uses a stack data structure to store and manipulate data. A stack is a Last In, First Out (LIFO) data structure, meaning that the most recently added item is the first one to be removed. In a stack-based language, operands are pushed onto the stack, and operations are performed by popping operands from the stack, processing them, and then pushing the result back onto the stack.

The main advantage of stack-based languages is their simplicity, as they often have a small number of instructions and can be easily implemented in hardware or software. Examples of stack-based languages include Forth, PostScript, and the custom 'code.ai' language implemented in this code.

## The 'code.ai' language and its implementation
The 'code.ai' language is a custom stack-based language inspired by Forth. Each word in the language is a subroutine that is called using the machine code "#,W", where "#" is a placeholder for the word that is looked up in the dictionary D to get the location in memory where the subroutine machine code is located. The compiler builds a threaded interpreted language style program that is loaded on the memory tape M and then executed. This is an example of subroutine threading.

### The main components of the code include:
* The code begins by loading the 'code.ai' language definitions from a file named 'code.ai'. The load function reads the file line by line and stores the words and their corresponding machine codes into two NumPy arrays, words and codes.
* Helper functions for dictionary lookups, code recoding, and setting up the memory tape.
* Compiling a given program into a series of instructions and operands.
* Executing the program using the custom virtual machine.


### Helper functions
The code defines several helper functions:

* D(word): A dictionary lookup function that returns the index of the given word in the words array, or -1 if the word is not found.
* recode(codes): A function that recodes the given codes by replacing each word with its corresponding index in the words array.
* setup(program): A function that sets up the memory tape M by initializing it with the compiled 'code.ai' language and the given program.
* compile_program(X): A function that compiles a given program X into a series of instructions and operands, suitable for execution by the virtual machine.

## Compiling the program
The compile_program(X) function takes a program X written in the 'code.ai' language and converts it into a sequence of instructions and operands that the virtual machine can execute. The function iterates through each element of the program, checks if it is a number, a comma-separated pair, or a word from the language, and then appends the corresponding machine codes to the compiled program.

## Executing the program
The run(M) function takes the memory tape M as input and executes the program using the custom virtual machine. The function implements the single native instruction (copy-paste) and several memory-mapped operations, such as addition, subtraction, multiplication, and division. It uses a while loop to iterate through the instructions in the memory tape, updating the instruction pointer IP and the memory locations according to the specified rules.

The virtual machine maintains two stacks: one for parameters (S) at location SL, and another for return addresses (W) at location WL. The copy-paste instruction is used to move values between memory locations, push and pop values to and from the stacks, and perform subroutine calls and returns.


## Subroutine threading
The 'code.ai' language uses subroutine threading, which means that each word in the language is treated as a subroutine (i.e., a sequence of instructions and operands that perform a specific task). When a word is called, the virtual machine jumps to the memory location where the subroutine's machine code is stored and begins executing it. The return address is pushed onto the return address stack (W) before the jump, and it is popped when the subroutine finishes executing, allowing the virtual machine to return to the original program.

Subroutine threading simplifies the implementation of the language, as the compiler only needs to generate machine codes that call the appropriate subroutines for each word in the program.

## Postfix notation and the simplicity of the compiler
The 'code.ai' language uses postfix notation, also known as Reverse Polish Notation (RPN), which is a mathematical notation where operators follow their operands. In postfix notation, there is no need for parentheses to indicate the order of operations, and the notation naturally corresponds to the stack-based execution model of the virtual machine.

The simplicity of postfix notation greatly simplifies the compiler for the 'code.ai' language, as there is no need to parse complex expressions or manage operator precedence. The compiler can focus on translating the words in the program into machine codes that manipulate the stacks and perform the desired operations.

In summary, the 'code.ai' language implementation demonstrates how a simple stack-based language with a single native instruction can be used to perform complex operations using subroutine threading, postfix notation, and a straightforward compiler. This implementation serves as a useful introduction to stack-based languages and the MPCR OISC concept.



## Further Reading
For those interested in diving deeper into stack-based languages, OISC, and the foundational principles of computing, refer to the following resources:

- [Starting Forth](https://github.com/williamedwardhahn/OISC/blob/main/Forth_Books/Starting%20FORTH%20Introduction%20to%20the%20FORTH%20Language%20and%20Operating%20System%20for%20Beginners%20and%20Professionals%20(Leo%20Brodie).pdf)
- [Thinking Forth](https://github.com/williamedwardhahn/OISC/blob/main/Forth_Books/Thinking%20Forth%20A%20Language%20and%20Philosophy%20for%20Solving%20Problems%20(Leo%20Brodie).pdf)
- [More Books](https://github.com/williamedwardhahn/OISC/tree/main/Forth_Books)

## Contributing & Support
We welcome contributions to improve and extend the OISC emulator. If you find any issues or have suggestions, please open an issue on the repository. For direct support or queries, reach out to the maintainers.

---

By embracing the simplicity of OISC, we hope to inspire developers and enthusiasts to rethink the essence of computing, emphasizing clarity, efficiency, and understanding over layers of complexity.

