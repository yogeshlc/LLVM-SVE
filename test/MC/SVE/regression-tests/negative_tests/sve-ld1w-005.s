// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load4SVZ
// Restricted predicate has range [0, 7].
ld1w z26.s, p8/z, [x6, z18.s, uxtw #2]
// CHECK: error: invalid operand
