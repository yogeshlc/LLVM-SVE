// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store2VSZ
// Restricted predicate has range [0, 7].
st1h z2.s, p8, [x15, z23.s, uxtw]
// CHECK: error: invalid operand
