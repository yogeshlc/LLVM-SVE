// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoad1LSSZ
// Restricted predicate has range [0, 7].
ld1b z18.h, p8/z, [x15, x19]
// CHECK: error: invalid operand
