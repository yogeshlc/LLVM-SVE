// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadFF2VSZ
// Restricted predicate has range [0, 7].
ldff1h z13.s, p8/z, [x30, z29.s, uxtw]
// CHECK: error: invalid operand
