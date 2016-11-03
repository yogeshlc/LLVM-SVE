// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoad1LSSZ
// Restricted predicate has range [0, 7].
ld1b z19.d, p8/z, [x2, x17]
// CHECK: error: invalid operand
