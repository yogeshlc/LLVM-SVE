// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF4VSZ
// Restricted predicate has range [0, 7].
ldff1w z10.d, p8/z, [x10, z0.d]
// CHECK: error: invalid operand
