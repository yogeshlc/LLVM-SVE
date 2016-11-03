// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF1VSZ
// Restricted predicate has range [0, 7].
ldff1b z12.d, p8/z, [x2, z5.d]
// CHECK: error: invalid operand
