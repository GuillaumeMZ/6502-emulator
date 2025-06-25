const Cpu = struct {
    accumulator: u8,
    x: u8,
    y: u8,
    pc: u16,
    sp: u8,
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
    },

    pub const frequency: u32 = 1_000_000; //in hertz

    /// Initializes the CPU's registers to the correct values, including the stack pointer to 0x1FF.
    pub fn init() Cpu {
        return .{
            .accumulator = 0,
            .x = 0,
            .y = 0,
            .pc = 0,
            .sp = 0xff,
            .status = 0b00000100, //bit 5 is always 1 (unused)
        };
    }
};
