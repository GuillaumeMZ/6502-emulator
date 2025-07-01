const expect = @import("std").testing.expect;

const Addressing = @import("./addressing.zig");
const Cpu = @import("./cpu.zig");

//test cases copied from https://en.wikibooks.org/wiki/6502_Assembly
//except the first one
test "relative addressing mode with a negative offset is calculated correctly" {
    var cpu = Cpu{};
    cpu.pc = 0x100;

    const result_address = try Addressing.effective_address(Addressing.AddressingMode{ .rel = -0x10 }, &cpu);

    try expect(result_address == 0xf0);
}

test "absolute indirect addressing mode address is calculated correctly" {
    var cpu = Cpu{};
    cpu.ram[0xa001] = 0xff;
    cpu.ram[0xa002] = 0x00;

    const result_address = try Addressing.effective_address(Addressing.AddressingMode{ .abs_ind = 0xa001 }, &cpu);

    try expect(result_address == 0x00ff);
}

test "zeropage indexed indirect with x addressing mode address is calculated correctly" {
    var cpu = Cpu{};
    cpu.x = 0x02;
    cpu.ram[17] = 0x10;
    cpu.ram[18] = 0xd0;

    const result_address = try Addressing.effective_address(Addressing.AddressingMode{ .zp_ind_ind_x = 15 }, &cpu);

    try expect(result_address == 0xd010);
}

test "zeropage indexed indirect with y addressing mode address is calculated correctly" {
    var cpu = Cpu{};
    cpu.y = 0x03;
    cpu.ram[0x2a] = 0x35;
    cpu.ram[0x2b] = 0xc2;

    const result_address = try Addressing.effective_address(Addressing.AddressingMode{ .zp_ind_ind_y = 0x2a }, &cpu);

    try expect(result_address == 0xc238);
}
