// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF8XSVZ
// Restricted predicate has range [0, 7].
ldff1d z0.d, p8/z, [x4, z15.d, sxtw #3]
// CHECK: error: invalid operand
