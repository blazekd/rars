package rars.riscv.instructions;

import rars.ProgramStatement;
import rars.riscv.InstructionSet;
import rars.riscv.hardware.RegisterFile;
import rars.riscv.BasicInstruction;
import rars.riscv.BasicInstructionFormat;

/*
Copyright (c) 2023,  Daniel Blazek

Developed by Daniel Blazek (blazeda5@fit.cvut.cz)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject
to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(MIT license, http://www.opensource.org/licenses/mit-license.html)
 */


public class ADDUQB extends BasicInstruction {
    public ADDUQB() {
        super("adduqb t1,t2,t3", "Add packed byte integers from t2 and t3 to t1. Ignore carry if bytes overflow. ", BasicInstructionFormat.R_FORMAT,
                "0000000 ttttt sssss 000 fffff 0010011");
    }


    public void simulate(ProgramStatement statement) {
        int[] operands = statement.getOperands();
        if (InstructionSet.rv64){
            RegisterFile.updateRegister(operands[0], compute(RegisterFile.getValueLong(operands[1]),RegisterFile.getValueLong(operands[2])));
        }else {
            RegisterFile.updateRegister(operands[0], computeW(RegisterFile.getValue(operands[1]),RegisterFile.getValue(operands[2])));
        }
    }

    /**
     * @param value  the value from the first register
     * @param value2 the value from the second register
     * @return the result to be stored from the instruction
     */
	public long compute(long value, long value2) {
		long i0 = ((value & 0xff000000) + (value2 & 0xff000000)) & 0xff000000;
		long i1 = ((value & 0x00ff0000) + (value2 & 0x00ff0000)) & 0x00ff0000;
		long i2 = ((value & 0x0000ff00) + (value2 & 0x0000ff00)) & 0x0000ff00;
		long i3 = ((value & 0x000000ff) + (value2 & 0x000000ff)) & 0x000000ff;
        return i0 + i1 + i2 + i3;
    }

    /**
     * A version for rv32 / W instructions in rv64, override if the default behaviour is not correct
     * @param value  the value from the first register truncated to 32 bits
     * @param value2 the value from the second register truncated to 32 bits
     * @return the result to be stored from the instruction
     */
    protected int computeW(int value, int value2){
        return (int) compute(value,value2);
    }
}
