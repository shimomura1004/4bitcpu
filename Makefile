VERILOG_SRCS=cpu.v ram.v

.PHONY:sim
sim: waveform_cpu.vcd waveform_ram.vcd

# .PHONY:build
# build: obj_dir/V$(MODULE)

.PHONY: waves_%
waves_%: waveform_%.vcd
	@echo
	@echo "### WAVES ###"
	gtkwave $<

waveform_%.vcd: ./obj_dir/V%
	@echo
	@echo "### SIMULATING ###"
	@./obj_dir/V$* +verilator+rand+reset+2

./obj_dir/V%: .stamp.%.verilate
	@echo
	@echo "### BUILDING SIM ###"
	make -C obj_dir -f $(@F).mk $(@F)

.stamp.%.verilate: %.v tb_%.cpp
	@echo
	@echo "### VERILATING ###"
	verilator -Wall --trace --x-assign unique --x-initial unique -cc $*.v --exe tb_$*.cpp
	@touch $@

.PHONY: lint_%
lint_%: %.v
	verilator --lint-only $*.v

.PHONY: clean
clean:
	rm -rf .stamp.*;
	rm -rf ./obj_dir;
	rm -rf waveform.vcd waveform_*.vcd
