const Ram = @import("./ram.zig");

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
    ._ = 1,
    .v = 0,
    .n = 0,
},
ram: *[Ram.RamSize]u8 = &Ram.Ram,

pub const frequency: u32 = 1_000_000; //in hertz
