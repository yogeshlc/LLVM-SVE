// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AndVIX
// Immediate not compatible with encode/decode function.
and z1.d, z1.d, #3776
// CHECK: error: expected compatible register or logical immediate
