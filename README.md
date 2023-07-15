# MiniC
```
		 __  __ _       _  _____ 
		|  \/  (_)     (_)/ ____|
		| \  / |_ _ __  _| |     
		| |\/| | | '_ \| | |     
		| |  | | | | | | | |____ 
		|_|  |_|_|_| |_|_|\_____|
```

A Simple C Language Compiler based on GCC, Bison (parser) and Flex (lexer).

## Features
MiniC is a simple C compiler with limited feature that listed below:

* Loop statement (if-else, for, while, switch)
* Pointer
* Constants
* 23 Operators
* 10 Data types

**and more features can be checked on lex and yacc files**

## Requirements

* [GCC](https://gcc.gnu.org/)
* [Bison](https://www.gnu.org/software/bison/)
* [Flex](https://sourceforge.net/projects/flex/) 

## Usages

Run code below on your terminal inside of the project directory.

```
bison -dy minic_parser.y

flex minic_lexer.l

gcc y.tab.c -o minic.exe
```

After successfully parsing and generating, now you can use the compiler to test C program like below

```
minic.exe<error_prog/if_else_err.c
```

Example above are testing `if_else_err.c` program under `error_prog` folder.
You can try another program that listed inside 'error_prog' and 'success_prog' folder, or from your own C program.

#### NOTE: This compiler are tested successfully under Windows 10 and Windows 11
