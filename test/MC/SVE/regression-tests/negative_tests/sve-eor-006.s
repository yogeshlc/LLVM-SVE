// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64XorVIX
// Immediate not compatible with encode/decode function.
eor z17.d, z17.d, #3520
// CHECK: error: expected compatible register or logical immediate
