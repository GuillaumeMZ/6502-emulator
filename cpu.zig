const Addressing = @import("./addressing.zig");
const AddressingMode = Addressing.AddressingMode;
const AddressingError = Addressing.AddressingError;
const Instruction = @import("./instruction.zig").Instruction;
const Ram = @import("./ram.zig");

const Self = @This();

accumulator: u8 = 0,
x: u8 = 0,
y: u8 = 0,
pc: u16 = 0,
sp: u8 = 0xff,
status: packed struct(u8) {
    //from bit 0 to bit 7
    c: u1,
    z: u1,
    i: u1,
    d: u1,
    b: u1,
    _: u1,
    v: u1,
    n: u1,
} = .{
    .c = 0,
    .z = 0,
    .i = 0,
    .d = 0,
    .b = 0,
    ._ = 1, //this unused bit is always 1
    .v = 0,
    .n = 0,
},
ram: *[Ram.RamSize]u8 = &Ram.Ram,

pub const frequency: u32 = 1_000_000; //in hertz

pub fn handle_adc(self: *Self, addressing_mode: AddressingMode) AddressingError!void {
    switch (addressing_mode) {
        .acc,
        .imp,
        .rel,
        .abs_ind,
        .zp_ind_ind_y,
        => return AddressingError.InvalidAddressingMode,
        else => {},
    }

    const value_to_add = try Addressing.effective_value(addressing_mode, &self);
    const carry = self.status.c;
    const accumulator = self.accumulator;

    const result, const overflow = @addWithOverflow(value_to_add + carry, accumulator);

    self.accumulator = result;
    self.status.n = if (result & 0b10000000 != 0) 1 else 0; //if bit 0 is 1
    self.status.v = overflow;
    self.status.z = if (result == 0) 1 else 0;
    self.status.c = overflow;
}

pub fn handle_clc(self: *Self) void {
    self.status.c = 0;
}
