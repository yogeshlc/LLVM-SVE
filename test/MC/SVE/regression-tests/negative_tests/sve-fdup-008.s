// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64DupI
// Immediate not compatible with encode/decode function.
fdup z20.d, #0.0
// CHECK: error: expected compatible register or floating-point constant
