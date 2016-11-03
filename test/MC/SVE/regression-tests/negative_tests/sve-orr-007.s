// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64OrVIX
// Immediate not compatible with encode/decode function.
orr z9.d, z9.d, #3776
// CHECK: error: expected compatible register or logical immediate
