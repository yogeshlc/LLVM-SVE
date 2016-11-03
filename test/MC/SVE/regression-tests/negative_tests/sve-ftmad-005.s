// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32TRIMADDVVI
// Source and Destination Registers must match
ftmad z25.s, z26.s, z24.s, #0
// CHECK: error: operand must match destination register
