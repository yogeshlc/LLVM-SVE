// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoad2SIZ
// Restricted predicate has range [0, 7].
ld1h z13.d, p8/z, [x28, #4, MUL VL]
// CHECK: error: invalid operand
