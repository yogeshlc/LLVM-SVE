// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoad1LSSZ
// Restricted predicate has range [0, 7].
ld1b z17.s, p8/z, [x28, x23]
// CHECK: error: invalid operand
