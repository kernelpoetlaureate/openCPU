module mini_cpu_mov_test;
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

    initial begin
        step = 0;
        // Program: mov eax, 5 (LOAD eax, [1])
        // mem[0] = LOAD eax, [1] (01_0_00001)
        // mem[1] = 5
        dut.mem[0] = 8'b01000001;
        dut.mem[1] = 8'd5;
        dut.mem[2] = 8'b00000000; // NOP
        dut.mem[3] = 8'b00000000; // NOP
        $monitor("pc=%d eax=%d ebx=%d mem0=%d mem1=%d", pc, eax, ebx, mem0, mem1);
        repeat (4) begin
            #5 step = 1;
            #5 step = 0;
        end
        $finish;
    end
endmodule
