A RISC-V processor implemented in SystemVerilog, verified with Verilator. The design fetches instructions from a hex memory image, executes the RV32I instruction set, and logs its execution trace for verification against a reference model.

## Architecture

The processor is organized into five stages — Fetch, Decode, Execute, Memory, and Writeback — each separated by clocked pipeline registers (`clk_fetch`, `clk_decode`, `clk_execute`, `clk_memory`, `clk_writeback`).

Key modules:

| Module | Responsibility |
|---|---|
| `instruction_memory` | Loads program from a hex file into sparse memory, combinationally serves fetch requests |
| `register` | 32-entry register file, synchronous write / combinational read |
| `control` | Decodes opcode/funct3/funct7 into ALU and datapath control signals |
| `ALU` | Executes arithmetic/logic operations |
| `extender` | Sign-extends immediates per instruction format (I/S/B/U/J) |
| `branch` | Resolves branch/jump targets and outcomes |
| `data_memory` | Load/store memory access |
| hazard unit | Flushes fetch/decode stages on a taken branch via per-stage enable signals |

Because branch outcomes are only known after Execute, a hazard unit stalls/flushes the Fetch and Decode stages on a taken branch, while instructions already past Execute (Memory, Writeback) complete normally.

## Repository Layout

```
src/
  pkg/       - shared packages (types, constants)
  clk/       - clocked pipeline stage registers
  mux/       - mux/demux helper modules
  *.sv       - core modules (ALU, register, control, branch, data_memory, instruction_memory, top)
tb/
  tb.sv      - testbench, top-level simulation entry point
```

## Requirements

- [Verilator](https://www.veripool.org/verilator/)
- GTKWave (optional, for waveform viewing)

## Build & Run

```bash
make lint    # static lint check
make build   # compile the design + testbench with Verilator
make run     # build and run the simulation
make wave    # run and open the waveform in GTKWave
make clean   # remove build artifacts and waveform dump
```

## Testing

The processor reads its program from `test.hex` (expected one directory above the project root, at `../test/test.hex`), a plain list of hex-encoded instruction words. Instruction addresses are not stored in the file — they're derived by the memory model, starting at `INST_START` and incrementing by 4 per line, matching the linear layout of the original `.text` section.

During simulation, the processor's execution trace (retired PC, instruction, register writes, memory accesses) is written to `model.log`. This output is compared against a reference trace; an exact match confirms the processor executes the test program correctly.

## Status

Verified against the reference test program — `model.log` matches the reference log exactly.

## Other Branches

The `non-pipelined` branch contains a multicycle (non-pipelined) version of the same processor. It has also been verified against the reference test suite.
