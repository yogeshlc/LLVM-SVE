// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32DupIM
// Immediate not compatible with encode/decode function.
fcpy z19.s, p0/m, #32.0
// CHECK: error: expected compatible register or floating-point constant
