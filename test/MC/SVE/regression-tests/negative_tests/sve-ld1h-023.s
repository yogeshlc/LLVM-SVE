// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load2VIZ
// Restricted predicate has range [0, 7].
ld1h z4.d, p8/z, [z23.d, #17]
// CHECK: error: invalid operand
