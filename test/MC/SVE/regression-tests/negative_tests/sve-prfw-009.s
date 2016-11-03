// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch4YSV
// Restricted predicate has range [0, 7].
prfw pstl2strm, p8, [x8, z28.s, uxtw #2]
// CHECK: error: invalid operand
