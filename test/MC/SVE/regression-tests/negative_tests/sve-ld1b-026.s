// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CLoad1LSSZ
// Restricted predicate has range [0, 7].
ld1b z3.b, p8/z, [x11, x17]
// CHECK: error: invalid operand
