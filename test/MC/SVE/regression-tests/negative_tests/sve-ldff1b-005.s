// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadFF1VSZ
// Restricted predicate has range [0, 7].
ldff1b z7.s, p8/z, [x13, z1.s, uxtw]
// CHECK: error: invalid operand
