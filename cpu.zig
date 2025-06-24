const CPU = struct {
    accumulator: u8,
    x: u8,
    y: u8,
    pc: u16,
    sp: u8,
    status: u8,

    pub const frequency: u32 = 1_000_000; //in hertz

    /// Initializes the CPU's registers to the correct values, including the stack pointer to 0x1FF.
    pub fn init() CPU {
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
