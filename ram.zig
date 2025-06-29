const std = @import("std");

pub const RamSize = 1 << 16;
pub var Ram: [RamSize]u8 = std.mem.zeroes([RamSize]u8);
