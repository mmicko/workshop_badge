module top(
    input clock_in,
    output lcd_clk,
    output [7:0] lcd_dat,
    output lcd_hsync,
    output lcd_vsync,
    output lcd_den,
    output lcd_reset);

wire clkhf;
wire locked;

(* ROUTE_THROUGH_FABRIC=1 *)
SB_HFOSC #(.CLKHF_DIV("0b01")) hfosc_i (
  .CLKHFEN(1'b1),
  .CLKHFPU(1'b1),
  .CLKHF(clkhf)
);

pll pll_i(.clock_in(clkhf), .clock_out(pixclk), .locked(locked));

lcdtest lcddrv_i (.clk(pixclk), //24 MHz pixel clock in
                  .resetn(locked),
                  .lcd_dat(lcd_dat),
                  .lcd_hsync(lcd_hsync),
                  .lcd_vsync(lcd_vsync),
                  .lcd_den(lcd_den));

  
assign lcd_clk = pixclk;

assign lcd_reset = 1'b1;
  
endmodule
