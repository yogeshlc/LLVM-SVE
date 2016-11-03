// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CLoad1LSSZ
// Restricted predicate has range [0, 7].
ld1sb z21.h, p8/z, [x5, x30]
// CHECK: error: invalid operand
