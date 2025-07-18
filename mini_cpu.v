module mini_cpu(
    input step,
    output [7:0] eax,
    output [7:0] ebx,
    output [3:0] pc,
    output [7:0] mem0,
    output [7:0] mem1,
    output [7:0] mem2,
    output [7:0] mem3
);
    reg [3:0] pc_r;
    reg [7:0] eax_r, ebx_r, mem [0:15], instr;
    assign eax = eax_r;
    assign ebx = ebx_r;
    assign pc = pc_r;
    assign mem0 = mem[0];
    assign mem1 = mem[1];
    assign mem2 = mem[2];
    assign mem3 = mem[3];

always @(posedge step) begin
    instr = mem[pc_r];
    case (instr[7:6])
        2'b01: begin // LOAD
            if (instr[5])
                ebx_r <= mem[instr[3:0]];
            else
                eax_r <= mem[instr[3:0]];
        end
        2'b10: begin // ADD
            if (instr[5])
                ebx_r <= eax_r + ebx_r;
            else
                eax_r <= eax_r + ebx_r;
        end
        2'b11: begin // STORE
            if (instr[5])
                mem[instr[3:0]] <= ebx_r;
            else
                mem[instr[3:0]] <= eax_r;
        end
    endcase
    pc_r <= pc_r + 1;
end
endmodule
