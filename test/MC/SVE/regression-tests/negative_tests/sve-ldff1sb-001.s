// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CLoadFF1LSSZ
// Restricted predicate has range [0, 7].
ldff1sb z8.s, p8/z, [x14, x14]
// CHECK: error: invalid operand
