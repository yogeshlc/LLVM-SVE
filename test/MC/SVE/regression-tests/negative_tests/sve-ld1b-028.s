// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CLoad1SIZ
// Restricted predicate has range [0, 7].
ld1b z28.b, p8/z, [x12, #7, MUL VL]
// CHECK: error: invalid operand
