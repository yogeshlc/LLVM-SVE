// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load4VSZ
// Restricted predicate has range [0, 7].
ld1w z13.d, p8/z, [x29, z26.d]
// CHECK: error: invalid operand
