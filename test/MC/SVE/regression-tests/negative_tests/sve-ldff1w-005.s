// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadFF4VSZ
// Restricted predicate has range [0, 7].
ldff1w z16.s, p8/z, [x21, z21.s, uxtw]
// CHECK: error: invalid operand
