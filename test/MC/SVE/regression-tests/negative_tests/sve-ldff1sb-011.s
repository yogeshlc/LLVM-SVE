// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF1VSZ
// Restricted predicate has range [0, 7].
ldff1sb z20.d, p8/z, [x13, z30.d]
// CHECK: error: invalid operand
