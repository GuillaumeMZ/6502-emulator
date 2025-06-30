const Cpu = @import("./cpu.zig");

const AddressingMode = union(enum) {
    acc,
    imp,
    imm: u8,
    abs: u16,
    zp: u8,
    rel: i8,
    abs_ind: u16,
    abs_ind_x: u16,
    abs_ind_y: u16,
    zp_ind_x: u8,
    zp_ind_y: u8,
    zp_ind_ind_x: u8,
    zp_ind_ind_y: u8,
};

pub fn effective_address(addressing_mode: AddressingMode, cpu: *const Cpu) !u16 {
    switch (addressing_mode) {
        .acc, .imp, .imm => return error.InvalidAddressingMode,
        .abs => |address| return address,
        .zp => |zp_offset| return zp_offset,
        .rel => |offset| return cpu.pc + offset,
        .abs_ind => |address| {
            const first_byte = cpu.ram[address];
            const second_byte = cpu.ram[address + 1];
            return (second_byte << 8) | first_byte;
        },
        .abs_ind_x => |address| return address + cpu.x,
        .abs_ind_y => |address| return address + cpu.y,
        .zp_ind_x => |zp_offset| return zp_offset + cpu.x,
        .zp_ind_y => |zp_offset| return zp_offset + cpu.y,
        .zp_ind_ind_x => |zp_offset| {
            const address = zp_offset + cpu.x;
            const first_byte = cpu.ram[address];
            const second_byte = cpu.ram[address];
            return (second_byte << 8) | first_byte;
        },
        .zp_ind_ind_y => |zp_offset| {
            const first_byte = cpu.ram[zp_offset];
            const second_byte = cpu.ram[zp_offset + 1];
            const address = (second_byte << 8) | first_byte;
            return address + cpu.y;
        },
    }
}
