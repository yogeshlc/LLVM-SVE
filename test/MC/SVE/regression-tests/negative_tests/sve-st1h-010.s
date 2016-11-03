// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store2SVZ
// Restricted predicate has range [0, 7].
st1h z15.s, p8, [x11, z28.s, uxtw #1]
// CHECK: error: invalid operand
