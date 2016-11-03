// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF4VIZ
// Restricted predicate has range [0, 7].
ldff1sw z19.d, p8/z, [z20.d, #1]
// CHECK: error: invalid operand
