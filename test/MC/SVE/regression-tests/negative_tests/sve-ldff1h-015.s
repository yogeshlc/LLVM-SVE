// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF2XSVZ
// Restricted predicate has range [0, 7].
ldff1h z3.d, p8/z, [x13, z2.d, sxtw #1]
// CHECK: error: invalid operand
