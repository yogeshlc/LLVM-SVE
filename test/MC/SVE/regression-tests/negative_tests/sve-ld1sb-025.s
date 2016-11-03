// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load1YVSZ
// Restricted predicate has range [0, 7].
ld1sb z18.d, p8/z, [x18, z3.d, uxtw]
// CHECK: error: invalid operand
