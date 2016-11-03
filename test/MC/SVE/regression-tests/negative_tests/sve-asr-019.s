// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrVWM
// Source and Destination Registers must match
asr z24.s, p4/m, z25.s, z3.d
// CHECK: error: operand must match destination register
