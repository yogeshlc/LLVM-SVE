// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF1VIZ
// Restricted predicate has range [0, 7].
ldff1sb z15.d, p8/z, [z26.d, #29]
// CHECK: error: invalid operand
