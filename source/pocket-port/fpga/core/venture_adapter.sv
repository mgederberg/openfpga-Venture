`default_nettype none

module venture_adapter (
    input  wire        clk_master,
    input  wire        clk_audio,
    input  wire        reset,
    input  wire [31:0] keys,

    input  wire [16:0] rom_addr,
    input  wire [7:0]  rom_data,
    input  wire        rom_wr,

    output wire [23:0] rgb,
    output wire        hs,
    output wire        vs,
    output wire        hblank,
    output wire        vblank,
    output wire        pix_ce,

    output wire signed [15:0] audio_l,
    output wire signed [15:0] audio_r
);

    // Pocket controls follow the established Scramble layout.
    wire m_up    = keys[0];
    wire m_down  = keys[1];
    wire m_left  = keys[2];
    wire m_right = keys[3];
    wire m_fire  = keys[4];
    wire m_coin  = keys[14];
    wire m_start = keys[15];

    wire red, green, blue;

    exidy2 game (
        .master_clock(clk_master),
        .audio_clk(clk_audio),

        // Venture Revision 5 MRA configuration.
        .pcb(8'h10),
        .mod_shift(8'h37),

        .RED(red),
        .GREEN(green),
        .BLUE(blue),
        .core_pix_clk(pix_ce),

        .H_SYNC(hs),
        .V_SYNC(vs),
        .H_BLANK(hblank),
        .V_BLANK(vblank),

        .RESET_n(~reset),
        .pause(1'b0),

        // Exidy2 controls are active-low.
        .m_right(~m_right),
        .m_left(~m_left),
        .m_down(~m_down),
        .m_up(~m_up),
        .m_fire(~m_fire),
        .m_yel(1'b1),
        .m_red(1'b1),
        .m_blu(1'b1),
        .m_start1p(~m_start),
        .m_start2p(1'b1),
        .m_coina(~m_coin),
        .m_coinb(1'b1),

        // Initial DIP settings from Venture's MRA.
        .DIP1(8'h80),
        .DIP2(8'hFF),
        .DIP3(8'h00),

        .dn_addr({8'd0, rom_addr}),
        .dn_wr(rom_wr),
        .dn_data(rom_data),

        .audio_l(audio_l),
        .audio_r(audio_r),

        // High-score access disabled for first bring-up.
        .hs_address(16'd0),
        .hs_data_out(),
        .hs_data_in(8'd0),
        .hs_write(1'b0)
    );

    // Original Exidy video is 1-bit per RGB channel.
    assign rgb = {
        {8{red}},
        {8{green}},
        {8{blue}}
    };

endmodule

`default_nettype wire
