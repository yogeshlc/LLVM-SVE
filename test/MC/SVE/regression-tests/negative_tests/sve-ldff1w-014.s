// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF4XSVZ
// Restricted predicate has range [0, 7].
ldff1w z26.d, p8/z, [x21, z5.d, sxtw #2]
// CHECK: error: invalid operand
