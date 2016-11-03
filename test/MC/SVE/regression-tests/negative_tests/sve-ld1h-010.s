// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load2SVZ
// Restricted predicate has range [0, 7].
ld1h z20.s, p8/z, [x3, z9.s, uxtw #1]
// CHECK: error: invalid operand
