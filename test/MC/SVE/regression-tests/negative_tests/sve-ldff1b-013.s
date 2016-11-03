// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF1YVSZ
// Restricted predicate has range [0, 7].
ldff1b z17.d, p8/z, [x19, z2.d, uxtw]
// CHECK: error: invalid operand
