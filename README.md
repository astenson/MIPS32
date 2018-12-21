# MIPS32
## Winter Break 2018 Project - 32-bit MIPS Out of Order Processor

##### Module that need to be created:
| Module                    | Parent Module | Start Date | Finish Date | Notes |
|:-------------------------:|:-------------:|:----------:|:-----------:|:-----:|
| MIPS                      | N/A           | 12/21/2018 | | Top Module |
| Instruction Cache         | MIPS          | | | 32kB, read-only, direct mapped, 32B block size, 1 cycle access latency and 10 cycle miss penalty |
| Instruction Fetch Module  | MIPS          | | | |
| Decode Queue              | MIPS          | 12/21/2018 | | 8-entry FIFO |
| Instruction Decode Module | MIPS          | | | |
| Rename Queue              | MIPS          | | | 8-entry FIFO |
| F-RAT                     | MIPS          | | | 35 architectural registers |
| 64-bit Free List          | MIPS          | | | |
| 16-bit Free List          | Issue Queue   | | | |
| Busy Bits                 | MIPS          | | | |
| Issue Queue               | MIPS          | | | 16-entry out of order |
| Arbitration Tree          | Issue Queue   | | | |
| Issue Queue Entry         | Issue Queue   | | | |
| Physical Register File    | MIPS          | 12/21/2018 | | 64 physical registers |
| Execute Module (EXE)      | MIPS          | | | |
| 32-bit ALU                | EXE           | | | |
| Load Queue                | MIPS          | | | 16-entry out of order |
| Store Queue               | MIPS          | | | 16-entry FIFO |
| Data Cache                | MIPS          | | | 32kB, write-back, write-allocate, 2-way, 32B block size, 1 cycle access latency with 10 cycle miss penalty |
| Reorder Buffer            | MIPS          | | | 64-entry |
| R-RAT                     | MIPS          | | | |
