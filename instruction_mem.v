module instruction_mem(
    input [31:0] A,
    output reg [31:0] RD
);

//Instruction memory array(ROM)
reg [31:0] mem[0:63];

integer i;

//Initialize the memory with program instructions(Hex form)
initial begin

////              Test Programs -->

    //(1) No Hazards
//    mem[0] = 32'h00500093;   // addi x1,x0,5
//    mem[1] = 32'h00A00113;   // addi x2,x0,10
//    mem[2] = 32'h00F00193;   // addi x3,x0,15
//    mem[3] = 32'h01400213;   // addi x4,x0,20
//    mem[4] = 32'h01900293;   // addi x5,x0,25
    
    //(2) Forwarding data
//    mem[0] = 32'h00500093;   // addi x1,x0,5
//    mem[1] = 32'h00108133;   // add x2,x1,x1
//    mem[2] = 32'h401101B3;   // sub x3,x2,x1
//    mem[3] = 32'h0021E233;   // or x4,x3,x2
//    mem[4] = 32'h003272B3;   // and x5,x4,x3

    //(3) Memory Operations
//      mem[0] = 32'h01900293;   // addi x5,x0,25
//      mem[1] = 32'h00502023;   // sw x5,0(x0)
//      mem[2] = 32'h00002303;   // lw x6,0(x0)

    //(4) Load-use hazard
//    mem[0] = 32'h00002083;   // lw x1,0(x0)
//    mem[1] = 32'h00108133;   // add x2,x1,x1
//    mem[2] = 32'h00A00193;   // addi x3,x0,10

    //(5) Control hazard(Branch flush)
//    mem[0] = 32'h00500093;   // addi x1,x0,5
//    mem[1] = 32'h00500113;   // addi x2,x0,5
//    mem[2] = 32'h00208463;   // beq x1,x2,+8
//    mem[3] = 32'h06300193;   // addi x3,x0,99 (should be flushed)
//    mem[4] = 32'h00100213;   // addi x4,x0,1
  
   //(7) COnsecutive dependencies  
    mem[0] = 32'h00100093;   // addi x1,x0,1
    mem[1] = 32'h00200113;   // addi x2,x0,2
    mem[2] = 32'h002081B3;   // add  x3,x1,x2
    mem[3] = 32'h00218233;   // add  x4,x3,x2
    mem[4] = 32'h003202B3;   // add  x5,x4,x3
    

    for(i=5;i<64;i=i+1)
        mem[i] = 32'h00000013;   // NOP
end

//initial begin
//    
//    for(i=0;i<64;i=i+1)
//        mem[i] = 32'h00000013;   // addi x0,x0,0 (NOP)
//        
//    $readmemh("program.hex",mem);
//end

//Reads the instruction corresponding to given address
always@(*) begin
    RD= mem[A[31:2]]; //Addresses being multiple of 4 contains 0 in last 2 bits(so we avoid them)
end

endmodule
