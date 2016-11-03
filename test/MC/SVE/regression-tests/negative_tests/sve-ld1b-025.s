// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load1YVSZ
// Restricted predicate has range [0, 7].
ld1b z8.d, p8/z, [x13, z29.d, uxtw]
// CHECK: error: invalid operand
