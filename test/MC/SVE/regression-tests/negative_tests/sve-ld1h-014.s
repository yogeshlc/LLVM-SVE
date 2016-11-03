// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load2VSZ
// Restricted predicate has range [0, 7].
ld1h z0.s, p8/z, [x20, z14.s, uxtw]
// CHECK: error: invalid operand
