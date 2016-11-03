// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32DupIM
// Immediate not compatible with encode/decode function.
fcpy z22.s, p8/m, #0.0
// CHECK: error: expected compatible register or floating-point constant
