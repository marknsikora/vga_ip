`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2015 04:18:08 PM
// Design Name: 
// Module Name: vga
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga
#(
    parameter  VID_IN_DATA_WIDTH = 24
)
(
// video output interface
    input   wire [VID_IN_DATA_WIDTH-1:0] vid_data,
    input   wire                         vid_active_video,
    input   wire                         vid_vsync,
    input   wire                         vid_hsync,
    input   wire                         vid_vblank,
    input   wire                         vid_hblank,
    input   wire                         vid_field_id,
    
    input   wire                         vid_io_out_clk,
    
// vga interface
    output  reg                    [3:0] vga_red,
    output  reg                    [3:0] vga_green,
    output  reg                    [3:0] vga_blue,
    output  reg                          vga_hsync,
    output  reg                          vga_vsync
);
    localparam PIXEL_WIDTH = VID_IN_DATA_WIDTH/3;
    
    always @(posedge vid_io_out_clk)
    begin
	  // VGA clocks are active low
      vga_hsync <= ~vid_hsync;
      vga_vsync <= ~vid_vsync;
      
	  // Blank video when now active
      if (vid_active_video == 1'b1)
      begin
        vga_blue  <= vid_data[VID_IN_DATA_WIDTH-1:VID_IN_DATA_WIDTH-4];
        vga_green <= vid_data[VID_IN_DATA_WIDTH-PIXEL_WIDTH-1:VID_IN_DATA_WIDTH-PIXEL_WIDTH-4];
        vga_red   <= vid_data[VID_IN_DATA_WIDTH-PIXEL_WIDTH*2-1:VID_IN_DATA_WIDTH-PIXEL_WIDTH*2-4];
      end
      else
      begin
        vga_blue  <= 4'b0;
        vga_green <= 4'b0;
        vga_red   <= 4'b0;
      end
    end
endmodule
