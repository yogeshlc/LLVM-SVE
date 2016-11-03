// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MovIM
// Immediate not compatible with encode/decode function.
fmov z1.d, p2/m, #0.2
// CHECK: error: expected compatible register or floating-point constant
