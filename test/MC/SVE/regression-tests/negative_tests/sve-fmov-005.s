// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MovI
// Immediate not compatible with encode/decode function.
fmov z4.d, #-0.11
// CHECK: error: expected compatible register or floating-point constant
