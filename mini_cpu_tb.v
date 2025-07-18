module mini_cpu_tb;
    reg step;
    wire [7:0] eax, ebx;
    wire [3:0] pc;
    wire [7:0] mem0, mem1, mem2, mem3;

    // Instantiate the CPU
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

    initial begin
        // Initialize step
        step = 0;

        // Initialize memory with a simple program:
        // mem[0] = LOAD eax, [1]   (01_0_00001)
        // mem[1] = 5               (data)
        // mem[2] = LOAD ebx, [1]   (01_1_00001)
        // mem[3] = ADD eax, ebx    (10_0_xxxx)
        // mem[4] = STORE eax, [2]  (11_0_00010)
        // mem[5] = NOP             (00_xxxxxx)
        dut.mem[0] = 8'b01000001;
        dut.mem[1] = 8'd5;
        dut.mem[2] = 8'b01100001;
        dut.mem[3] = 8'b10000000;
        dut.mem[4] = 8'b11000010;
        dut.mem[5] = 8'b00000000;

        // Monitor outputs
        $monitor("pc=%d eax=%d ebx=%d mem0=%d mem1=%d mem2=%d mem3=%d", pc, eax, ebx, mem0, mem1, mem2, mem3);

        // Step through a few cycles
        repeat (10) begin
            #5 step = 1;
            #5 step = 0;
        end
        $finish;
    end
endmodule
