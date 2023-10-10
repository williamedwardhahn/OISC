module oisc (input rst, input rdy, input [15:0] d_in, output [15:0] addr, output reg [15:0] d_out, output w_en);
  reg [3:0] s;
  assign w_en = s[3];
  reg [15:0] ip, last_in;
  wire [15:0] inc = ip + 1;
  assign addr = (s[0] | s[2]) ? ip : last_in;
always @(posedge rst or posedge rdy) begin
  if (rst) {s, ip} <= {4'b0001,16'h0100};
    else begin
        last_in <= d_in;
      d_out <= |{~s[2],d_out} ? last_in : inc;
      ip <= (s[2] || s[0]) ? |{s[0],d_in} ? inc : last_in : ip;
      s <= {s[2:0],s[3]};
    end
end endmodule





module simplealu (input clk, input rst, input w_en, input [15:0] d_in,
                  input [2:0] addr, output reg [15:0] d_out, output reg rdy);
 
  reg [15:0] a, b;
  
  always @(posedge clk) begin
    if (rst) begin
      a <= 0;
      b <= 0;
      rdy <= 0;
    end else if (rdy) begin
      rdy <= 0;
    end else begin
    case (addr)
      0: if (w_en) a <= d_in; else d_out <= a;
      1: if (w_en) b <= d_in; else d_out <= b; 
      2: d_out <= a+b; /*
      3: d_out <= a^b;
      4: d_out <= a&b;
      5: d_out <= a|b;
      6: d_out <= {16{a==b}};
      7: d_out <= {16{a<b}};*/
    endcase
    rdy <= 1;
    end
  end
  
endmodule

module top (input clk, input rst, 
            output reg w_en, output reg [15:0] addr, 
            output reg [15:0] d_out, output reg [15:0] oisc_d_in,
            input [15:0] d_in, input d_rdy, output oisc_rdy);

  wire alu_en;
  assign alu_en = addr[15] && (addr[14:3] == 0);
  wire alu_rdy;
  wire [15:0] alu_d_out;
  wire [2:0] alu_addr;
  assign alu_addr = alu_en ? addr[2:0] : 3'h0;
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
    .w_en(w_en && alu_en),
    .d_in(alu_en ? d_out : 16'h0),
    .addr(alu_addr),
    .d_out(alu_d_out),
    .rdy(alu_rdy)
  );
  
  // memory
  wire mem_en;
  assign mem_en = addr[15:10] == 0;
  reg [15:0] mem [0:1023];
  always @(posedge clk) begin
    if (mem_en) begin
      if (w_en)
        mem[addr[9:0]] <= d_out;
      else
        mem_d_in <= mem[addr[9:0]];
    end
  end
  wire mem_rdy;
  assign mem_rdy = ~clk;
  
  initial begin
    mem[256] = 16'h108;
mem[257] = 16'h8000;
mem[258] = 16'h109;
mem[259] = 16'h8001;
mem[260] = 16'h8002;
mem[261] = 16'h109;
mem[262] = 16'h10a;
mem[263] = 16'h0;
mem[264] = 16'h1;
mem[265] = 16'h0;
mem[266] = 16'h100;
  end
  always @(*) begin
    if (mem_en) begin
      oisc_d_in = mem_d_in; // Get data from memory
      oisc_rdy = mem_rdy;
    end else if (alu_en) begin
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


        
