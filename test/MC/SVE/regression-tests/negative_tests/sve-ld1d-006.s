// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load8VIZ
// Restricted predicate has range [0, 7].
ld1d z27.d, p8/z, [z2.d, #26]
// CHECK: error: invalid operand
