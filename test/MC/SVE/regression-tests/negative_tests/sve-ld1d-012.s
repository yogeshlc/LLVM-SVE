// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load8YSVZ
// Restricted predicate has range [0, 7].
ld1d z9.d, p8/z, [x3, z13.d, uxtw #3]
// CHECK: error: invalid operand
