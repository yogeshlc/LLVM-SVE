// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64DupMaskI
// Immediate not compatible with encode/decode function.
dupm z11.d, #3008
// CHECK: error: expected compatible register or logical immediate
