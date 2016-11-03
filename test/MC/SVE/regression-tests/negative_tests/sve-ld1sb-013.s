// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32Load1VSZ
// Restricted predicate has range [0, 7].
ld1sb z15.s, p8/z, [x14, z18.s, uxtw]
// CHECK: error: invalid operand
