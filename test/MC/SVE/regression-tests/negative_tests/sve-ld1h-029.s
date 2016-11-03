// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load2YSVZ
// Restricted predicate has range [0, 7].
ld1h z26.d, p8/z, [x1, z13.d, uxtw #1]
// CHECK: error: invalid operand
