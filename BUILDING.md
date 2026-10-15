# Building Venture for Analogue Pocket

Toolchain: Intel Quartus Prime Lite 21.1.1 Build 850.

The packaged source compiled successfully on Debian
using the raetro/quartus:21.1 Docker image.

From the repository root, run:

    docker run --rm -v "$PWD/source:/project" -w /project/pocket-port/fpga raetro/quartus:21.1 quartus_sh --flow compile ap_core


Build output: source/pocket-port/fpga/output_files/

No commercial arcade ROMs are supplied.
Successful compilation does not guarantee a bit-identical
result to the distributed FPGA bitstream.
