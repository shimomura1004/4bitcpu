#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <deque>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vcpu.h"

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7

vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vcpu *dut = new Vcpu;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform_cpu.vcd");

    while (sim_time < MAX_SIM_TIME) {
        dut->reset = 0;
        if (sim_time >= 3 && sim_time < 6) {
            dut->reset = 1;
        }

        dut->clk ^= 1;
        dut->eval();

        // emulate RAM
        if (dut->clk == 1) {
            posedge_cnt++;

            if (posedge_cnt >= 4) {
                switch (dut->addr) {
                case 0x00:
                    dut->dout = 0b01100000; // inc R0
                    break;
                case 0x01:
                    dut->dout = 0b10000000; // jnc 0000
                    break;
                case 0x02:
                    dut->dout = 0b10100000; // mvi 0000
                    break;		
                case 0x03:
                    dut->dout = 0b10010000; // jmp 0
                    break;
                default:
                    break;
                }
            }
        }

        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    exit(EXIT_SUCCESS);
}
