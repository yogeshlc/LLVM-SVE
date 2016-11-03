// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load4XSVZ
// Restricted predicate has range [0, 7].
ld1w z2.d, p8/z, [x21, z27.d, sxtw #2]
// CHECK: error: invalid operand
