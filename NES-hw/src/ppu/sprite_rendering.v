`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:32 09/30/2023 
// Design Name: 
// Module Name:    sprite_rendering 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sprite_rendering(
    // clock and reset
    input wire        clk,
    input wire        rst, 

    //Data inputs
    input wire  [7:0] slv_mem_din, //Slave mem bus interface
    input wire  [7:0] ppu_mem_din, //video memory interface

    //Signals related to the OAM access
    input wire        oam_addr_wr,
    input wire        oam_data_wr,
    output reg [7:0]  oam_dout,

    //Input control signals
    input wire        bground_enabled, // background rendering enabled
    input wire        sprite_enabled,  // sprite rendering enable
    input wire        no_sprite_clip,  // indicates if the sprite in the first column should be rendered
    input wire        first_column,    // indicates the first background column
    input wire        sprite_size,     // 8x16 or 8x8 sprites
    input wire        next_pixel,      // Indicates the rendering of the next pixel
    input wire        start_rendering, // Indicates the start of rendering
    input wire        scanline_begin,  // Indicates the start of NES scanline
    input wire        bgnd_read_end,   // Indicates the end of background data read
    input wire        pattern0_read,   // Video memory read: pattern table byte 0 
    input wire        pattern1_read,   // Video memory read: pattern table byte 1
    input wire        bground_read,    // Background data read signal 
    input wire        sprite_read,     // Sprite data read signal 
    input wire        sprite_read_end, 
    input wire        nes_scanline_end,
    input wire        rendering_end,

    //Output control signals
    output wire       lost_sprite_set,
    output wire       sprite0_visible, //sprite 0 pixel is visible

    //Output sprite data
    output reg  [7:0] sprite_tile_index,//sprite tile index
    output reg  [3:0] sprite_range,     //Sprite line index
    output wire [4:0] sprite_pixel,     //Sprite pixel color (palette index) 
    output wire       sprite_priority   //Sprite priority
    );

//*****************************************************************************
//* counting all the verical rows from pre rendering up to VBLANK             *
//*****************************************************************************
reg [8:0] scanline_cnt = 9'd511;

always @(posedge clk) 
begin
    if (rst || start_rendering)
        scanline_cnt <= 9'd511;
    else
        if (sprite_read_end)
            scanline_cnt <= scanline_cnt + 9'd1;
end

//*****************************************************************************
//* Signals of the even/odd pixels                                            *
//*****************************************************************************
reg [2:0]   pixel_cnt;
wire        pixel_cnt_overflow = (pixel_cnt == 3'b111);

always @(posedge clk) 
begin
    if (rst || scanline_begin)
        pixel_cnt <= 3'd0;
    else
        if (next_pixel)
            pixel_cnt <= pixel_cnt + 3'd1;
end

// rendering enabled
wire ppu_enable = bground_enabled | sprite_enabled; 

// basically the odd and even pixels rendering its enables the phase signals only for a clk because of next pixel
//even
wire even_phase_en = pixel_cnt[0] & next_pixel & ppu_enable;
//odd
wire odd_phase_en = ~pixel_cnt[0] & next_pixel & ppu_enable;
wire odd_phase    = ~pixel_cnt[0] & next_pixel;

//*****************************************************************************
//* Priamary OAM address counters                                             *
//*****************************************************************************
reg [7:0] pri_oam_addr_cnt;

always @(posedge clk) 
begin
    if (rst)
        pri_oam_addr_cnt <= 8'd0;
    else
        if (oam_addr_wr)
            pri_oam_addr_cnt <= slv_mem_din;
        else
            if (oam_data_wr) // this is when sprite dma bang 2004
                pri_oam_addr_cnt <= pri_oam_addr_cnt + 8'd1;    
end


//Counters for sprite evaluation
//OAM[n][m] below refers to the byte at offset 4*n + m within OAM, i.e. OAM byte m (0-3) of sprite n (0-63)
reg [1:0] m_cnt; //which byte in the sprite
wire      m_cnt_overflow = (m_cnt == 2'd3);
wire      m_cnt_clr;
reg       m_cnt_en;

always @(posedge clk) 
begin
    if (scanline_begin || bgnd_read_end || m_cnt_clr)
        m_cnt <= 2'd0;
    else
        if (m_cnt_en)
            m_cnt <= m_cnt + 2'd1;    
end

reg [5:0] n_cnt; // wich sprite from 64
wire      n_cnt_overflow = (n_cnt == 6'd63);
reg       n_cnt_en;
reg       n_cnt_max_reached;

always @(posedge clk) 
begin
    if (scanline_begin || bgnd_read_end)
        n_cnt <= 6'd0;
    else
        if (n_cnt_en)
            n_cnt <= n_cnt + 6'd1;
end

always @(posedge clk) 
begin
    if (scanline_begin)
        n_cnt_max_reached <= 1'b0;
    else
        if (n_cnt_en && n_cnt_overflow)
            n_cnt_max_reached <= 1'b1;    
end

//*****************************************************************************
//* Primary Object Attribute Memory                                           *
//*****************************************************************************
(* ram_style = "distributed" *)
reg  [7:0]  pri_oam [255:0];
reg  [7:0]  pri_oam_addr;
wire [1:0]  pri_oam_addr_sel;
wire [7:0]  pri_oam_dout = pri_oam[pri_oam_addr];

always @(*) 
begin
    case (pri_oam_addr_sel)
        2'b01:   pri_oam_addr <= {n_cnt, m_cnt};
        2'b11:   pri_oam_addr <= {pri_oam_addr[7:3], n_cnt[0], m_cnt}; // i dont exatcly know this
        default: pri_oam_addr <= pri_oam_addr_cnt; 
    endcase    
end

always @(posedge clk) 
begin
    if (oam_data_wr)
        pri_oam[pri_oam_addr] <= slv_mem_din;    
end

//*****************************************************************************
//* Secondary Primary OAM dout                                                *
//*****************************************************************************
reg  [7:0]  oam_temp_reg = 8'hFF;
wire        oam_temp_reg_set;
reg         oam_temp_reg_wr;

always @(posedge clk) 
begin
    if (rst || oam_temp_reg_set)
        oam_temp_reg <= 8'hFF;
    else
        if (oam_temp_reg_wr)
            oam_temp_reg <= pri_oam_dout;    
end

//*****************************************************************************
//* Testing the visibility of the sprite                                      *
//*****************************************************************************
reg  [8:0]  y_diff_reg1;
wire        sprite_in_range = (sprite_size) ? (y_diff_reg1[8:4] == 5'd0) : (y_diff_reg1[8:3] == 6'd0);


// if I subtract from scanline cntr - tile_addr then check the upper bits of y_diff_reg to be zero then we have a sprite in range
always @(posedge clk) 
begin
    if (rst)
        y_diff_reg1 <= 9'd0;
    else
        if (oam_temp_reg_wr)
            y_diff_reg1 <= scanline_cnt - {1'b0, pri_oam_dout};    
end

//*****************************************************************************
//* Secondary OAM address counter                                             *
//*****************************************************************************
reg  [4:0]  sec_oam_addr_cnt;
wire        sec_oam_addr_cnt_overflow = (sec_oam_addr_cnt == 5'd31);
reg         sec_oam_addr_cnt_en;

always @(posedge clk) 
begin
    if (rst || scanline_begin || bgnd_read_end)
        sec_oam_addr_cnt <= 5'd0;
    else
        if (sec_oam_addr_cnt_en)
            sec_oam_addr_cnt <= sec_oam_addr_cnt + 5'd1;    
end

//*****************************************************************************
//* Secondary Object Attribute Memory                                         *
//*****************************************************************************
(* memory_style = "distributed" *)
reg  [7:0]  sec_oam [31:0];
wire [7:0]  sec_oam_dout = sec_oam[sec_oam_addr_cnt];
reg         sec_oam_wr;
wire        sec_oam_rd;

always @(posedge clk) 
begin
    if (sec_oam_wr)
        sec_oam[sec_oam_addr_cnt] <= oam_temp_reg;  
end

//*****************************************************************************
//* Register that stores the sprite line index                                *
//* The vertical inversion is applied here                                    *
//*****************************************************************************
reg  [3:0]  y_diff_reg2;
wire        y_diff_reg2_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b00);

always @(posedge clk) 
begin
    if (rst)
        y_diff_reg2 <= 4'd0;
    else
        if (y_diff_reg2_wr)
            y_diff_reg2 <= scanline_cnt[3:0] - sec_oam_dout[3:0];    
end

wire sprite_range_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b11);
wire v_inversion;

always @(posedge clk) 
begin
    if (rst)
        sprite_range <= 4'd0;
    else
        if (sprite_range_wr)
            sprite_range <= y_diff_reg2 ^ {4{v_inversion}};    
end

//*****************************************************************************
//* Register that stores the sprite tile index                                *
//*****************************************************************************
wire sprite_tile_index_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b01);

always @(posedge clk) 
begin
    if (rst)
        sprite_tile_index <= 8'd0;
    else
        if (sprite_tile_index_wr)
            sprite_tile_index <= sec_oam_dout;    
end

//*****************************************************************************
//* Register that stores the sprite attribute data                            *
//*****************************************************************************
reg  [4:0]  sprite_attributes;
wire        sprite_attribute_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b10);

always @(posedge clk) 
begin
    if (rst)
        sprite_attributes <= 5'd0;
    else
        if (sprite_attribute_wr)
            sprite_attributes <= {sec_oam_dout[7:5], sec_oam_dout[1:0]};
end

// Vertical inversion bit
assign v_inversion = sprite_attributes[4];

//*****************************************************************************
//* Register that stores the sprite X-coordinate                              *
//*****************************************************************************
reg  [7:0]  sprite_x_coord;
wire        sprite_x_coord_wr = sec_oam_rd & (sec_oam_addr_cnt[1:0] == 2'b11);

always @(posedge clk) 
begin
    if (rst)
        sprite_x_coord <= 8'd0;
    else
        if (sprite_x_coord_wr)
            sprite_x_coord <= sec_oam_dout; 
end

//*****************************************************************************
//* Controller state machine                                                  *
//*****************************************************************************
localparam  OAM_IDLE            = 4'd0;
localparam  OAM_SCANLINE_WAIT   = 4'd1;
localparam  OAM_INITIALIZE      = 4'd2;
localparam  OAM_COPY_Y_COORD    = 4'd3;
localparam  OAM_COPY_TILE       = 4'd4;
localparam  OAM_COPY_ATTRIB     = 4'd5;
localparam  OAM_COPY_X_COORD    = 4'd6;
localparam  OAM_SPR_OVERFLOW1   = 4'd7;
localparam  OAM_SPR_OVERFLOW2   = 4'd8;
localparam  OAM_SPR_OVERFLOW3   = 4'd9;
localparam  OAM_SPR_OVERFLOW4   = 4'd10;
localparam  OAM_HBLANK_WAIT     = 4'd11;
localparam  OAM_SPR_DATA_RD1    = 4'd12;
localparam  OAM_SPR_DATA_RD2    = 4'd13;
localparam  OAM_SPR_DATA_RD3    = 4'd14;

reg [3:0] oam_state;

always @(posedge clk) 
begin
    if (rst)
        oam_state <= OAM_IDLE;
    else
        case (oam_state)
            // Waiting for the beginning of rendering (end of VBLANK)
            OAM_IDLE:   if (start_rendering)
                            oam_state <= OAM_SCANLINE_WAIT;
                        else
                            oam_state <= OAM_IDLE;
            // waiting for the beginning of the NES scanline        
            OAM_SCANLINE_WAIT:  if (scanline_begin)
                                    oam_state <= OAM_INITIALIZE;
                                else
                                    if (rendering_end)
                                        oam_state <= OAM_IDLE;
                                    else
                                        oam_state <= OAM_SCANLINE_WAIT;
            // initializing the secondary oam with 0xFF
            OAM_INITIALIZE: if (odd_phase && sec_oam_addr_cnt_overflow)
                                oam_state <= OAM_COPY_Y_COORD;
                            else
                                oam_state <= OAM_INITIALIZE;
            // testing sprite visibility and copying the Y coordinate
            OAM_COPY_Y_COORD:   if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        if (sprite_in_range)
                                            oam_state <= OAM_COPY_TILE;
                                        else
                                            if (n_cnt_overflow)
                                                oam_state <= OAM_HBLANK_WAIT;
                                            else
                                                oam_state <= OAM_COPY_Y_COORD;
                                    else
                                        oam_state <= OAM_COPY_Y_COORD;
            // copy the sprite tile index
            OAM_COPY_TILE:  if (bgnd_read_end)
                                oam_state <= OAM_SPR_DATA_RD1;
                            else
                                if (odd_phase_en)
                                    oam_state <= OAM_COPY_ATTRIB;
                                else
                                    oam_state <= OAM_COPY_TILE;
            // Copy the sprite attribete data
            OAM_COPY_ATTRIB:    if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        oam_state <= OAM_COPY_X_COORD;
                                    else
                                        oam_state <= OAM_COPY_ATTRIB;
            // copy the sprite x-coordinate
            OAM_COPY_X_COORD:   if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        if (n_cnt_overflow)
                                            oam_state <= OAM_HBLANK_WAIT;
                                        else
                                            if (sec_oam_addr_cnt_overflow)
                                                oam_state <= OAM_SPR_OVERFLOW1;
                                            else
                                                oam_state <= OAM_COPY_Y_COORD;
                                    else
                                        oam_state <= OAM_COPY_X_COORD;
            // checking the secondary oam is full
            OAM_SPR_OVERFLOW1:  if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        if (sprite_in_range)
                                            oam_state <= OAM_SPR_OVERFLOW2;
                                        else
                                            if (n_cnt_overflow)
                                                oam_state <= OAM_HBLANK_WAIT;
                                            else
                                                oam_state <= OAM_SPR_OVERFLOW1;
                                    else
                                        oam_state <= OAM_SPR_OVERFLOW1;
            // sprite overtflow
            OAM_SPR_OVERFLOW2:  if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        oam_state <= OAM_SPR_OVERFLOW3;
                                    else
                                        oam_state <= OAM_SPR_OVERFLOW2;
            // sprite overtflow
            OAM_SPR_OVERFLOW3:  if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        oam_state <= OAM_SPR_OVERFLOW4;
                                    else
                                        oam_state <= OAM_SPR_OVERFLOW3;
            // sprite overtflow
            OAM_SPR_OVERFLOW4:  if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    if (odd_phase_en)
                                        oam_state <= OAM_SPR_OVERFLOW1;
                                    else
                                        oam_state <= OAM_SPR_OVERFLOW4;
            // Waiting for the end of the background data read
            OAM_HBLANK_WAIT:    if (bgnd_read_end)
                                    oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    oam_state <= OAM_HBLANK_WAIT;
            // reading the sprite data from the secondary oam
            OAM_SPR_DATA_RD1:   if (next_pixel && (sec_oam_addr_cnt[1:0] == 2'd3))
                                    oam_state <= OAM_SPR_DATA_RD2;
                                else
                                    oam_state <= OAM_SPR_DATA_RD1;
            // waiting for the end of the last sprite byte
            OAM_SPR_DATA_RD2:   if (next_pixel && pixel_cnt_overflow)
                                    if (sec_oam_addr_cnt_overflow)
                                        oam_state <= OAM_SPR_DATA_RD3;
                                    else
                                        oam_state <= OAM_SPR_DATA_RD1;
                                else
                                    oam_state <= OAM_SPR_DATA_RD2;
            // waiting for the end of nes scanline
            OAM_SPR_DATA_RD3:   if (nes_scanline_end)
                                    oam_state <= OAM_SCANLINE_WAIT;
                                else
                                    oam_state <= OAM_SPR_DATA_RD3;
            // invalid state
            default:    oam_state <= OAM_IDLE;
        endcase    
end

//Primary OAM address select signal
// if we are in VBLANK we wait for dma to copy primary oam
assign pri_oam_addr_sel[0] = ppu_enable & ~((oam_state == OAM_IDLE) | (oam_state == OAM_SCANLINE_WAIT));
assign pri_oam_addr_sel[1] = (n_cnt[5:1] == 5'd0) & ~n_cnt_max_reached;

//Primary OAM M address counter clear signal
assign m_cnt_clr = odd_phase_en & (oam_state == OAM_SPR_OVERFLOW1) & ~sprite_in_range & n_cnt_overflow;

//Primary OAM M address counter enable signal
always @(*) 
begin
    case (oam_state)
        OAM_COPY_Y_COORD: m_cnt_en <= odd_phase_en & sprite_in_range;
        OAM_COPY_TILE: m_cnt_en <= odd_phase_en;
        OAM_COPY_ATTRIB: m_cnt_en <= odd_phase_en;
        OAM_COPY_X_COORD: m_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW1: m_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW2: m_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW3: m_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW4: m_cnt_en <= odd_phase_en;
        default: m_cnt_en <= 1'b0;
    endcase    
end

//Primary OAM N address counter enable signal
always @(*) 
begin
    case (oam_state)
        OAM_COPY_Y_COORD: n_cnt_en <= odd_phase_en & ~sprite_in_range;
        OAM_COPY_X_COORD: n_cnt_en <= odd_phase_en;
        OAM_SPR_OVERFLOW1: n_cnt_en <= odd_phase_en & (~sprite_in_range | m_cnt_overflow);
        OAM_SPR_OVERFLOW2: n_cnt_en <= odd_phase_en & m_cnt_overflow;
        OAM_SPR_OVERFLOW3: n_cnt_en <= odd_phase_en & m_cnt_overflow;
        OAM_SPR_OVERFLOW4: n_cnt_en <= odd_phase_en & m_cnt_overflow;
        OAM_HBLANK_WAIT: n_cnt_en <= odd_phase_en;
        default: n_cnt_en <= 1'b0;
    endcase    
end

//Temporary data register set signal
assign oam_temp_reg_set = scanline_begin | bgnd_read_end;

//Temprory data register write en signal
always @(*) 
begin
    case (oam_state)
        OAM_COPY_Y_COORD: oam_temp_reg_wr <= even_phase_en;
        OAM_COPY_TILE: oam_temp_reg_wr <= even_phase_en;
        OAM_COPY_ATTRIB: oam_temp_reg_wr <= even_phase_en;
        OAM_COPY_X_COORD: oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_OVERFLOW1: oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_OVERFLOW2: oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_OVERFLOW3: oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_OVERFLOW4: oam_temp_reg_wr <= even_phase_en;
        OAM_HBLANK_WAIT: oam_temp_reg_wr <= even_phase_en;
        OAM_SPR_DATA_RD2: oam_temp_reg_wr <= sprite_read_end;
        default: oam_temp_reg_wr <= 1'b0;
    endcase 
end

//Secondary OAM address counter enable signal
always @(*) 
begin
    case (oam_state)
        OAM_INITIALIZE: sec_oam_addr_cnt_en <= odd_phase;
        OAM_COPY_Y_COORD: sec_oam_addr_cnt_en <= odd_phase_en & sprite_in_range;
        OAM_COPY_TILE: sec_oam_addr_cnt_en <= odd_phase_en;
        OAM_COPY_ATTRIB: sec_oam_addr_cnt_en <= odd_phase_en;
        OAM_COPY_X_COORD: sec_oam_addr_cnt_en <= odd_phase_en;
        OAM_SPR_DATA_RD1: sec_oam_addr_cnt_en <= next_pixel & (sec_oam_addr_cnt[1:0] != 2'd3); // only count in RD1 this is the read from secondary oam
        OAM_SPR_DATA_RD2: sec_oam_addr_cnt_en <= next_pixel & pixel_cnt_overflow;
        default: sec_oam_addr_cnt_en <= 1'b0;
    endcase    
end

// secondary OAM write enable signal
always @(*) 
begin
    case (oam_state)
        OAM_INITIALIZE: sec_oam_wr <= odd_phase;
        OAM_COPY_Y_COORD: sec_oam_wr <= odd_phase_en;
        OAM_COPY_TILE: sec_oam_wr <= odd_phase_en;
        OAM_COPY_ATTRIB: sec_oam_wr <= odd_phase_en;
        OAM_COPY_X_COORD: sec_oam_wr <= odd_phase_en;
        default: sec_oam_wr <= 1'b0;
    endcase
end

//Secondery OAM read enable signal
assign sec_oam_rd = (oam_state == OAM_SPR_DATA_RD1) & next_pixel;

//Sprite overflow flag set signal
assign lost_sprite_set = odd_phase_en & (oam_state == OAM_SPR_OVERFLOW1) & sprite_in_range;

//*****************************************************************************
//* Drive the output data bus                                                 *
//*****************************************************************************
wire oam_dout_sel = ppu_enable & ~((oam_state == OAM_IDLE) | (oam_state == OAM_SCANLINE_WAIT));

always @(*) 
begin
    case (oam_dout_sel)
        1'b0: oam_dout <= pri_oam_dout; 
        1'b1: oam_dout <= oam_temp_reg;
    endcase    
end

//*****************************************************************************
//* Sprite0 in range signal                                                   *
//*****************************************************************************
reg [1:0] sprite0_in_range;
// sprite0_visible set 
assign sprite0_visible = sprite0_in_range[1] | sprite0_in_range[0]; // not fully sure 

always @(posedge clk) 
begin
    if (rst)
        sprite0_in_range <= 2'd0;
    else
        if (scanline_begin)
            sprite0_in_range <= {sprite0_in_range[0], 1'd0};
        else
            if (odd_phase_en && (oam_state == OAM_COPY_X_COORD) && (n_cnt == 6'd0))
                sprite0_in_range <= {sprite0_in_range[1], 1'b1};
end

//*****************************************************************************
//* Registers that stores the validity of the sprites                         *
//*****************************************************************************
reg [7:0] valid_sprite; // fill up when we find a valid sprite 
// it is important if not all the 8 sprite was found the other sprites are invisible

always @(posedge clk) 
begin
    if (rst || scanline_begin)
        valid_sprite <= 8'd0;
    else
        if (odd_phase_en && (oam_state == OAM_COPY_X_COORD))
            valid_sprite <= {valid_sprite[6:0], 1'b1};
end

//*****************************************************************************
//* Sprite buffers                                                            *
//*****************************************************************************
wire    [3:0]  sprite_buff_pixel [7:0];
wire    [7:0]  sprite_buff_priority;
genvar         i;

generate
    for(i = 0; i < 8; i = i + 1)
    begin: sprite_buffer_load
        wire pattern0_ld = pattern0_read & sprite_read & (sec_oam_addr_cnt[4:2] == i);
        wire pattern1_ld = pattern1_read & sprite_read & (sec_oam_addr_cnt[4:2] == i);

        sprite_buffer sprite_buffer(
            .clk(clk),
            .rst(rst),

            // input controll signals
            .bground_read(bground_read),
            .next_pixel(next_pixel),
            .pattern0_ld(pattern0_ld),
            .pattern1_ld(pattern1_ld),

            //Data input
            .valid_sprite(valid_sprite[i]),
            .sprite_attr_in(sprite_attributes[3:0]),
            .sprite_x_in(sprite_x_coord),
            .pattern_in(ppu_mem_din),

            //Data out
            .sprite_pixel(sprite_buff_pixel[i]),
            .sprite_priority(sprite_buff_priority[i])
        );
    end
endgenerate

//*****************************************************************************
//* Sprite priority mux                                                       *
//*****************************************************************************


endmodule
