module oisc (input rst, input rdy, input [15:0] d_in,
    output [15:0] addr, output reg [15:0] d_out, output reg w_en);

reg s1, s2, s3;
reg [15:0] r1, r2;
wire [15:0] inc = r1 + 1;

assign addr = (s1 | s3) ? r1 : r2;

always @(posedge rst or posedge rdy) begin
    if (rst) {w_en, s3, s2, s1, r1} <= 20'h10100;
    else begin
        r2 <= d_in;
        d_out <= |{~s3,d_out} ? r2 : inc;
        r1 <= (s3 || s1) ? |{s1,d_in} ? inc : r2 : r1;
        {w_en, s3, s2, s1} <= {s3, s2, s1, w_en};
    end
end endmodule

module simplealu (input clk, input rst, input w_en, input [15:0] d_in,
                  input [2:0] addr, output reg [15:0] d_out, output rdy);
 
  reg [15:0] a, b;
  
  assign rdy = ~clk;
  
  always @(posedge clk) begin
    if (rst) begin
      a <= 0;
      b <= 0;
    end else
    case (addr)
      0: if (w_en) a <= d_in; else d_out <= a;
      1: if (w_en) b <= d_in; else d_out <= b; 
      2: d_out <= a+b;
      3: d_out <= a^b;
      4: d_out <= a&b;
      5: d_out <= a|b;
      6: d_out <= {16{a==b}};
      7: d_out <= {16{a<b}};
    endcase
  end
  
endmodule

module top (input clk, input rst, 
            output reg w_en, output reg [15:0] addr, 
            output reg [15:0] d_out, output reg [15:0] oisc_d_in,
            input [15:0] d_in, input d_rdy, output oisc_rdy);

  wire alu_rdy;
  wire [15:0] alu_d_out;
  wire [2:0] alu_addr;
  assign alu_addr = addr[2:0];
  reg [15:0] mem_d_in;

  oisc core(
    .rst(rst),
    .d_in(oisc_d_in),
    .addr(addr),
    .rdy(oisc_rdy),
    .d_out(d_out),
    .w_en(w_en)
  );
  
  simplealu alu(
    .clk(clk),
    .rst(rst),
    .w_en(w_en && (addr[15] && (addr[14:3] == 0))),
    .d_in(d_out),
    .addr(alu_addr),
    .d_out(alu_d_out),
    .rdy(alu_rdy)
  );
  
  // memory
  reg [15:0] mem [0:1023];
  always @(posedge clk) begin
    if (addr[15:10] == 0) begin
      if (w_en)
        mem[addr[9:0]] <= d_out;
      else
        mem_d_in <= mem[addr[9:0]];
    end
  end
  wire mem_rdy;
  assign mem_rdy = ~clk;
  
  always @(*) begin
    if (addr[15:10] == 0) begin
      oisc_d_in = mem_d_in; // Get data from memory
      oisc_rdy = mem_rdy;
    end else if (addr[15] && (addr[14:3] == 0)) begin
      oisc_d_in = alu_d_out; // Get data from the ALU
      oisc_rdy = alu_rdy;
    end else begin
      oisc_d_in = d_in;
      oisc_rdy = d_rdy;
    end
  end
  
  // You can now set 'use_external_data' based on your requirements. 
  // For example, if a specific condition is met, you can set it to 1 
  // to use the external data. Otherwise, set it to 0.

endmodule


        
