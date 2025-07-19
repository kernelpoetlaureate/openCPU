module mini_cpu_interactive_tb;
    reg step;
    wire [7:0] eax, ebx;
    wire [3:0] pc;
    wire [7:0] mem0, mem1, mem2, mem3;

    mini_cpu dut(
        .step(step),
        .eax(eax),
        .ebx(ebx),
        .pc(pc),
        .mem0(mem0),
        .mem1(mem1),
        .mem2(mem2),
        .mem3(mem3)
    );

    reg [7:0] instr_mem [0:15];
    integer i;

    initial begin
        // Load instructions from a file (edit 'program.mem' as needed)
        $readmemh("program.mem", instr_mem);
        // Copy to DUT memory
        for (i = 0; i < 16; i = i + 1) dut.mem[i] = instr_mem[i];

        step = 0;
        $display("Step-by-step CPU simulation. State after each step:");
        $display(" pc  eax  ebx  mem0 mem1 mem2 mem3");
        for (i = 0; i < 8; i = i + 1) begin
            #5 step = 1;
            #5 step = 0;
            $display("%3d %4d %4d %5d %5d %5d %5d", pc, eax, ebx, mem0, mem1, mem2, mem3);
        end
        $finish;
    end
endmodule
