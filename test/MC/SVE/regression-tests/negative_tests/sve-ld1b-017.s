// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoad1SIZ
// Restricted predicate has range [0, 7].
ld1b z23.d, p8/z, [x17, #13, MUL VL]
// CHECK: error: invalid operand
