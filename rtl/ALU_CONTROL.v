module alucontrol(input [6:0] opcode,input [2:0] funct3,input [6:0]funct7,output reg[3:0] alucontrol);
  always@(*)begin
    case (opcode)
      7'b0110011: begin
        case(funct3)
          3'b000:begin
            if(funct7==7'b0100000)
                        alucontrol = 4'b0001; // SUB
                    else
                        alucontrol = 4'b0000; // ADD
                end
                3'b111:
                    alucontrol = 4'b0010; // AND
                3'b110:
                    alucontrol = 4'b0011; // OR
                 3'b100:
                    alucontrol = 4'b0100; // XOR
                3'b001:
                    alucontrol = 4'b0101; // SLL
                3'b101: begin
                    if (funct7 == 7'b0100000)
                        alucontrol = 4'b0111; // SRA
                    else
                        alucontrol = 4'b0110; // SRL
                end
                3'b010:
                    alucontrol = 4'b1000; // SLT
                3'b011:
                    alucontrol = 4'b1001; // SLTU
                default:
                    alucontrol = 4'b0000;

            endcase
        end
      7'b0010011: begin

            case (funct3)

                3'b000:
                    alucontrol = 4'b0000; // ADDI
                3'b111:
                    alucontrol = 4'b0010; // ANDI
                3'b110:
                    alucontrol = 4'b0011; // ORI
                3'b100:
                    alucontrol = 4'b0100; // XORI
                3'b010:
                    alucontrol = 4'b1000; // SLTI
                3'b011:
                    alucontrol = 4'b1001; // SLTIU
                3'b001:
                    alucontrol = 4'b0101; // SLLI
                3'b101: begin
                    if (funct7 == 7'b0100000)
                        alucontrol = 4'b0111; // SRAI
                    else
                        alucontrol = 4'b0110; // SRLI
                end
                default:
                    alucontrol = 4'b0000;
            endcase
        end
        // Load
        7'b0000011:
            alucontrol = 4'b0000; // ADD
        // Store
        7'b0100011:
            alucontrol = 4'b0000; // ADD
        // Branch
        7'b1100011:
            alucontrol = 4'b0001; // SUB
        default:
            alucontrol = 4'b0000;
    endcase
end
endmodule
