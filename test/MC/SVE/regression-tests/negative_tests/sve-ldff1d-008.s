// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF8YSVZ
// Restricted predicate has range [0, 7].
ldff1d z16.d, p8/z, [x17, z0.d, uxtw #3]
// CHECK: error: invalid operand
