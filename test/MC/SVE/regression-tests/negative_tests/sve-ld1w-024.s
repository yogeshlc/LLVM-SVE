// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load4YSVZ
// Restricted predicate has range [0, 7].
ld1w z18.d, p8/z, [x18, z1.d, uxtw #2]
// CHECK: error: invalid operand
