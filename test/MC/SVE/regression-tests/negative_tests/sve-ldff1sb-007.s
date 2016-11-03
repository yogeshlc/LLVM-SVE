// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoadFF1LSSZ
// Restricted predicate has range [0, 7].
ldff1sb z0.d, p8/z, [x14, x22]
// CHECK: error: invalid operand
