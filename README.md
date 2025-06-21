# 6502 emulator

## Objectives

* Write a 6502 emulator capable of running all the defined operations (or a subset ?)
* Write an assembler for the emulator.

## How the 6502 works (briefly)

* Opcodes are encoded on one byte.
* 2-bytes values are stored in little endian.
* Registers:
    |Name|Size (bytes)|Usage|
    |---|---|---|
    |A|1|Accumulator for arithmetic and binary operations|
    |X|1|Used for memory addressing|
    |Y|1|Used for memory addressing|
    |PC|2|Program counter|
    |SP|2|Stack pointer| 
    |S|1|Status register|
* 65536 bytes can be addressed in the memory.
* The memory is divided into *pages*. The size of a page is 256 bytes. There are 256 pages.
* The stack is located in page $01, so it is 256 bytes long. It goes from address `$0100` to `$01FF`.
* The stack is *descending* (meaning the bottom of the stack is at address `$01FF`) and is *empty* (meaning SP points to the first available cell).

## Resources

* [6502 assembly](https://en.wikibooks.org/wiki/6502_Assembly)
* [6502 instruction set](https://www.masswerk.at/6502/6502_instruction_set.html)
* [6502 registers](https://plus4world.powweb.com/plus4encyclopedia/500149)
* [6502 stack](https://www.nesdev.org/wiki/Stack)
* [The 6502 processor](https://people.cs.umass.edu/~verts/cmpsci201/spr_2004/Lecture_02_2004-01-30_The_6502_processor.pdf)