const expect = @import("std").testing.expect;

const Addressing = @import("./addressing.zig");
const AddressingMode = Addressing.AddressingMode;
const Cpu = @import("./cpu.zig");

//test cases copied from http://www.6502.org/tutorials/vflag.html
test "the carry flag is properly set by the adc instruction" {
    var cpu = Cpu{};

    //first test case
    cpu.clc();
    cpu.accumulator = 1;

    try cpu.adc(AddressingMode{ .imm = 1 });

    try expect(cpu.accumulator == 2);
    try expect(cpu.status.c == 0);

    //second test case
    cpu.clc();
    cpu.accumulator = 1;

    try cpu.adc(AddressingMode{ .imm = 0xff });

    try expect(cpu.accumulator == 0);
    try expect(cpu.status.c == 1);

    //third test case
    cpu.clc();
    cpu.accumulator = 0x7f;

    try cpu.adc(AddressingMode{ .imm = 1 });

    try expect(cpu.accumulator == 128);
    try expect(cpu.status.c == 0);

    //fourth test case
    cpu.clc();
    cpu.accumulator = 128;

    try cpu.adc(AddressingMode{ .imm = 255 });

    //try expect(cpu.accumulator == ?);
    try expect(cpu.status.c == 1);
}
