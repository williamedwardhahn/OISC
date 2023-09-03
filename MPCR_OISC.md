
# MPCR OISC Documentation

## 1. Introduction:
Hahn's VM is a One Instruction Set Computer (OISC) that operates using a unique set of commands. Its architecture is reminiscent of a Forth-like environment, supporting direct subroutine threading and various operations.

## 2. Memory:

- **Unified Memory Model:** The VM uses a singular memory structure that stores both data (like variables) and code (commands).
- **Dictionary (`D` Function):** A critical component, it's used to associate words (like function or variable names) with their corresponding addresses in memory.

## 3. Basic Concepts:

- **Ordered Pairs:** All machine code consists of ordered pairs separated by commas, e.g., `5,L L,S`.
- **Stack-Based:** Operations largely rely on stack manipulations. Pushing, popping, and inspecting the stack are fundamental operations.
- **Literal Values:** Literal values can be loaded onto the stack using the `L` command. For instance, `5,L L,S` pushes the number 5 onto the stack.

## 4. Core Operations:

- **Arithmetic**:
  - `+`: Addition
  - `-`: Subtraction
  - `*`: Multiplication
  - `/`: Division
  - `Mod`: Modulus operation
  - `Negate`: Negate a number
  - `++`: Increment by 1
  - `--`: Decrement by 1
  - `Double`: Double the number
  - `Halve`: Halve the number
  - `Cube`: Raise to the third power
  - `Fourth`: Raise to the fourth power

- **Relational**:
  - `>`: Greater than check
  - `<`: Less than check
  - `==`: Equality check

- **Logical**:
  - `Not`: Logical NOT operation

- **Memory**:
  - `!,W`: Store a value in memory. Requires a value and an address (word) on the stack.
  - `@,W`: Retrieve a value from memory.

- **Stack Manipulations**:
  - `Over`: Copy the second-to-top item to the top of the stack.
  - `Rot`: Move the third item to the top of the stack.
  - `Drop`: Discard the top item of the stack.

- **Control Flow**:
  - `Branch`: Conditional branching based on a boolean value on the stack. Requires addresses for both true and false branches.

## 5. Special Registers and Locations:

- **Input Registers:** `A` and `B` for arithmetic operations.
- **Output Registers:** Resultant of arithmetic operations are stored in `Add`, `Sub`, `Mult`, and `Div`.
- **Special Stacks:** 
  - `S`: General-purpose stack.
  - `W`: Return address stack, mainly used for subroutines.

## 6. Programming Tips:

- **Stack Management:** Ensure required values are on the top of the stack. For instance, before arithmetic operations, load the operand values onto the stack.
- **Memory Usage:** When using named memory locations, ensure they are defined in the dictionary. Use `!,W` for storing and `@,W` for retrieving values.
- **Chained Operations:** Multiple operations can be chained. Ensure the stack contains the correct values in order for the operations to execute correctly.
- **Debugging:** Track the stack's state to debug issues. Ensure all commands are written in ordered pairs format.

## Understanding the Basics

### The Concept of Virtual Machines

Before diving into the MPCR OISC, it's essential to understand what a virtual machine (VM) is. A VM is a software-based representation of a physical computer. It emulates a real computer system's architecture, allowing multiple VMs to run simultaneously on a single physical machine. In the context of the MPCR OISC, the VM is a simulated environment that understands and executes the unique set of commands defined for the OISC.

### Introduction to OISC (One Instruction Set Computer)

OISC stands for "One Instruction Set Computer." As the name suggests, it's a computing architecture that operates with just one instruction. The idea might seem counterintuitive at first—how can a system function with just one command? However, the beauty of OISC lies in its simplicity and the creative ways in which this single instruction can be manipulated to perform a wide range of tasks.

The MPCR OISC, while reminiscent of the OISC paradigm, offers a minimal set of commands, each designed for specific tasks. This minimalism forces the programmer to think differently, focusing on the core logic of operations rather than relying on a vast set of commands.

### Memory in MPCR OISC: Unified Memory Model

One of the standout features of the MPCR OISC is its unified memory model. Unlike traditional systems that separate code and data into different memory areas, the MPCR OISC uses a single memory structure for both. This unified approach has its advantages:

1. **Flexibility:** The same memory locations can be used for storing data or code, allowing for dynamic programming techniques.
2. **Simplicity:** A singular memory model reduces complexity, making it easier to understand and manage memory operations.
3. **Efficiency:** With careful management, the unified memory model can lead to optimized memory usage, ensuring that no memory space is wasted.


## The Heart of the MPCR OISC: The Dictionary

### Role of the Dictionary

The dictionary is a pivotal component of the MPCR OISC. It serves as a key-value store where 'words' are mapped to their corresponding addresses in memory. In a way, the dictionary acts as the 'brain' of the system, allowing for the storage and retrieval of both data and code.

### How Words are Stored and Retrieved

The dictionary operates in a straightforward manner. When a new word is introduced, it gets associated with an address in the unified memory model. This association is permanent for the duration of the program, allowing for quick and efficient data retrieval.

For example, consider storing the number 5 in a memory location named 'Apple'. The dictionary will create an association like so:

```
Apple -> Address X
```

Where `Address X` is the location in memory where the number 5 is stored.

### Practical Use Cases

The dictionary's role goes beyond mere storage. It's the backbone for various advanced features in MPCR OISC:

1. **Subroutines:** By storing the address of a series of commands, the dictionary allows for subroutine calls, encapsulating complex operations under a single word.
2. **Dynamic Programming:** With the dictionary, you can create words on-the-fly, enabling dynamic and flexible programming techniques.
3. **Optimization:** By storing frequently used operations or data, the dictionary can significantly speed up program execution.


## Programming Basics in MPCR OISC

### Understanding Ordered Pairs

At the heart of the MPCR OISC's programming paradigm is the concept of ordered pairs. Every command, every operation, is represented as a pair of values separated by a comma. This might seem unusual at first, especially for those accustomed to more traditional programming languages. However, once grasped, this format offers a unique and efficient way to represent operations.

For instance, the operation `5,L L,S` is an ordered pair that pushes the number 5 onto the stack.

### The Importance of the Stack

The stack is a foundational concept in the MPCR OISC. Almost all operations involve pushing to or popping from the stack. It's a last-in, first-out (LIFO) data structure, which means the last item pushed onto the stack is the first one to be popped off.

Why is the stack so crucial?

1. **Immediate Data Access:** The top of the stack always contains the most recently accessed or added data, allowing for quick operations.
2. **Memory Efficiency:** Data that's no longer needed can be efficiently discarded.
3. **Simplifies Operations:** Many operations, like arithmetic or memory storage, rely on the top items of the stack, reducing the need for explicit data references.

### Loading Literal Values

In the MPCR OISC, literal values (like numbers) are loaded onto the stack using the `L` command. This command is often paired with another, like `S`, to push the value onto the stack. The command `5,L L,S`, for example, first loads the number 5 as a literal and then pushes it to the stack.

Understanding how to load literals is essential, as they form the basis for many operations. Whether you're performing arithmetic, storing values in memory, or making decisions based on comparisons, you'll often start by loading the necessary literals onto the stack.


## Arithmetic Operations in MPCR OISC

### Basic Arithmetic

The MPCR OISC provides a set of commands to perform basic arithmetic operations:

- **Addition (`+`)**: Add two numbers.
- **Subtraction (`-`)**: Subtract one number from another.
- **Multiplication (`*`)**: Multiply two numbers.
- **Division (`/`)**: Divide one number by another.

Loading operands onto the stack precedes each of these operations. The result is then pushed back onto the stack.

### Advanced Arithmetic

Apart from the basic arithmetic operations, the MPCR OISC offers commands for:

- **Modulus (`Mod`)**: Get the remainder of a division operation.
- **Negate (`Negate`)**: Change the sign of a number.
- **Increment (`++`)**: Add 1 to a number.
- **Decrement (`--`)**: Subtract 1 from a number.

### Handling Results

Once an arithmetic operation is performed, the result is placed on top of the stack. From here, it can be used in subsequent operations, stored in a memory location, or outputted for the user.


## Relational and Logical Operations in MPCR OISC

### Relational Operations

Relational operations allow for the comparison of two values. The MPCR OISC provides commands for:

- **Greater Than (`>`)**: Check if one value is greater than another.
- **Less Than (`<`)**: Check if one value is less than another.
- **Equality (`==`)**: Check if two values are equal.

Each of these operations examines the top two values on the stack and pushes a result (either 0 or 1) back onto the stack. A result of 1 indicates the condition is true, and 0 indicates false.

### Logical Operations

Logical operations are essential for making decisions based on multiple conditions. The primary logical operation provided by the MPCR OISC is:

- **Logical NOT (`Not`)**: It inverts a boolean value. If the top of the stack is 0, it becomes 1 and vice versa.

### Combining Relational and Logical Operations

By combining relational and logical operations, complex decision-making processes can be implemented. For instance, checking if a value is within a specific range involves using both the `>` and `<` commands in conjunction.

### Branching Based on Results

The results of relational and logical operations often lead to branching—executing different sets of commands based on a condition. The `Branch` command in the MPCR OISC allows for conditional execution based on the top value of the stack.



## Memory Operations in MPCR OISC

### Understanding Memory in MPCR OISC

In the MPCR OISC, memory serves as the primary storage area for both data and code. Thanks to its unified memory model, the same memory space can accommodate variables, constants, and sequences of commands.

### Storing and Retrieving Values

Two fundamental operations related to memory are storing (`!,W`) and retrieving (`@,W`) values. To store a value in a specific memory location:

1. Push the value onto the stack.
2. Push the memory location's name onto the stack.
3. Execute the `!,W` command.

To retrieve a value:

1. Push the memory location's name onto the stack.
2. Execute the `@,W` command.

### The Role of the Dictionary in Memory Operations

The dictionary ties names to specific memory addresses. When storing or retrieving values, the dictionary is consulted to find the appropriate address for the given name.

### Practical Examples

Consider storing the number 5 in a memory location named 'Apple':

```
5,L L,S Apple,S !,W
```

Later, to retrieve this value:

```
Apple,S @,W
```

## Stack Operations in MPCR OISC

### The Essence of the Stack

As a stack-based system, the MPCR OISC heavily relies on its stack for operations. The stack, a LIFO (Last-In, First-Out) data structure, is where values are stored temporarily for operations, from arithmetic to memory storage and retrieval.

### Fundamental Stack Operations

Several commands in MPCR OISC allow for the manipulation of the stack:

- **Pushing Values:** Using the `L,S` command, literal values are pushed onto the stack.
- **Over (`Over`)**: Duplicates the second-to-top item on the stack.
- **Rot (`Rot`)**: Moves the third item to the top of the stack.
- **Drop (`Drop`)**: Removes and discards the top item of the stack.

### Importance of Stack Management

Effective stack management is crucial in MPCR OISC:

1. **Order Matters:** Since many operations, like arithmetic, rely on the order of values on the stack, managing the stack's order is essential.
2. **Avoiding Overflows and Underflows:** Pushing too many values can lead to a stack overflow, while trying to retrieve a value from an empty stack results in a stack underflow.

### Practical Examples

Consider adding two numbers, 5 and 3:

```
5,L L,S 3,L L,S +
```

In this sequence, the numbers are first pushed onto the stack, and then the addition operation is executed, utilizing the top two values.



## Control Flow in MPCR OISC

### What is Control Flow?

Control flow, in programming, refers to the order in which individual statements, instructions, or function calls are executed. In traditional programming languages, constructs like loops, conditional statements, and function calls dictate control flow. In the context of the MPCR OISC, control flow is managed using a limited set of commands, making it an intriguing study.

### Conditional Execution with `Branch`

The `Branch` command in the MPCR OISC allows for conditional execution of code. It examines the top value of the stack and decides the next set of commands to execute based on this value. If the value is `0` (false), one set of commands is executed; otherwise, another set of commands is chosen.

### Iterative Operations with `Loop`

While the MPCR OISC doesn't have traditional looping constructs like 'for' or 'while', iterative operations can be achieved by creatively combining commands. Using `Branch` along with stack manipulations can emulate loop-like behavior.

### Practical Examples

Consider a scenario where we want to execute a set of commands if a condition is true and another set if it's false:

```
[... condition checks ...]
TrueCommands,S FalseCommands,S One Branch
```

If the result of the condition checks is `1` (true), `TrueCommands` will be executed. Otherwise, `FalseCommands` will be run.



## Special Registers and Locations in MPCR OISC

### Unveiling Special Locations

The MPCR OISC introduces several special locations that are pivotal for its operation. These locations are not just ordinary memory addresses but serve specific functions, enabling the machine to perform its tasks.

### Key Registers:

- **L:** The literal register, used for loading values directly onto the stack.
- **S:** The stack register, serving as the primary interface for all stack operations.
- **W:** The return address stack, playing a critical role in subroutine calls and returns.
- **A & B:** Operand registers, holding the values for arithmetic and relational operations.
- **Add, Sub, Mult, & Div:** Operator output locations, reflecting the results of the respective arithmetic operations.

### Working with Special Locations

The true power of the MPCR OISC is harnessed when these special locations are used in combination with the provided commands. For instance:

- To add two numbers, they are first loaded into the A and B registers, and the result is then retrieved from the `Add` location.
- Subroutine calls and returns are managed using the `W` register, ensuring seamless transitions between different code segments.

### Memory Management and Special Locations

It's crucial to understand that while these special locations serve specific purposes, they are part of the unified memory model. This integration ensures efficient memory usage and optimizes data retrieval and storage operations.

## Best Practices and Optimization in MPCR OISC

### The Need for Optimization

Given the MPCR OISC's minimalist nature, efficient programming is paramount. Optimizing code not only ensures faster execution but also makes the best use of the limited set of commands and the unified memory model.

### Key Best Practices:

1. **Minimize Stack Operations:** Excessive pushing and popping from the stack can slow down execution. Whenever possible, use operations that directly manipulate values in the necessary registers or locations.
2. **Efficient Use of Memory:** With the unified memory model, judicious use of memory is crucial. Avoid unnecessary storage operations and make the best use of the dictionary for quick data retrieval.
3. **Limit Use of Conditional Branching:** While conditional branching is powerful, over-reliance can lead to complex and hard-to-debug code. Use it judiciously and aim for linear code execution where possible.
4. **Modularize Code with Subroutines:** Create reusable code chunks as subroutines. This not only makes the code more readable but also allows for optimization at the subroutine level.

### Advanced Optimization Techniques:

- **Inline Expansion:** For frequently used short subroutines, consider expanding them inline to save on the overhead of subroutine calls.
- **Loop Unrolling:** For loops with a known number of iterations, unrolling them can lead to faster execution at the expense of slightly larger code.

### Embracing the Minimalist Philosophy

The MPCR OISC is all about simplicity and minimalism. Embrace this philosophy by focusing on the core logic of operations rather than getting lost in intricate command sequences. Often, the simplest solution is also the most optimized.



## Advanced Topics in MPCR OISC

### Delving Deeper

As we venture further into the MPCR OISC's capabilities, it's essential to explore advanced topics that showcase the full potential of this unique machine.

### Dynamic Programming in MPCR OISC

One of the MPCR OISC's intriguing features is its ability to support dynamic programming. By creating words on-the-fly, you can implement flexible programming techniques that adjust based on the input or conditions.

### Debugging and Profiling

Given the MPCR OISC's minimalist nature, traditional debugging methods might not always apply. Instead, you need to develop a keen sense for tracking the flow of data, especially the stack's state, and understanding how different commands manipulate it.

### Interfacing with External Systems

While the MPCR OISC is a standalone machine, it's conceivable to interface it with external systems, expanding its capabilities. This might involve:

- **Input/Output Operations:** Reading data from external sources or writing results out.
- **Integration with Other Programming Paradigms:** Combining the MPCR OISC's operations with other programming languages or systems.

### Emulating the MPCR OISC

Given its simplicity, the MPCR OISC is an excellent candidate for emulation. By creating emulators in different programming languages, you can study its behavior in various environments and even expand upon its basic design.



## Glossary of Terms

### A
- **A Register:** One of the operand registers in the MPCR OISC used for arithmetic and relational operations.

### B
- **B Register:** The second operand register in the MPCR OISC, complementing the A register.

### C
- **Control Flow:** The order in which individual statements, instructions, or function calls are executed within a program.

### D
- **Dictionary:** A key component in the MPCR OISC that ties names to specific memory addresses, facilitating efficient data storage and retrieval.

### L
- **L Register (Literal):** A special register used for loading values directly onto the stack.

### M
- **MPCR OISC:** A minimalist programmable command set computer (OISC) designed by Hahn. It operates on a set of commands and special locations, emulating the behavior of a virtual machine.

### O
- **OISC (One Instruction Set Computer):** A type of computer that has only one command, showcasing the power of minimalism in computing.

### S
- **S Register (Stack):** The primary interface for all stack operations in the MPCR OISC.

### U
- **Unified Memory Model:** A memory architecture where both data and code share the same memory space.

### W
- **W Register:** Represents the return address stack in the MPCR OISC, crucial for subroutine calls and returns.

---

*The glossary aims to provide quick definitions for terms and concepts used throughout this guide. It serves as a reference point for readers to clarify concepts and ensure a deeper understanding of the MPCR OISC.*
