// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CLoadFF1LSSZ
// Restricted predicate has range [0, 7].
ldff1sb z8.h, p8/z, [x8, x19]
// CHECK: error: invalid operand
