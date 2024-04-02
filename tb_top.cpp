#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <deque>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vtop.h"

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7

vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vtop *dut = new Vtop;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform_top.vcd");

    while (sim_time < MAX_SIM_TIME) {
        dut->reset = 0;
        if (sim_time >= 3 && sim_time < 6) {
            dut->reset = 1;
        }

        dut->clk ^= 1;
        dut->eval();

        if (dut->clk == 1) {
            posedge_cnt++;
        }

        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    exit(EXIT_SUCCESS);
}
