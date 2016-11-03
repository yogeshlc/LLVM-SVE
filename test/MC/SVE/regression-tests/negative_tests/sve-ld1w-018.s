// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load4VIZ
// Restricted predicate has range [0, 7].
ld1w z27.d, p8/z, [z14.d, #24]
// CHECK: error: invalid operand
