// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store4SVZ
// Restricted predicate has range [0, 7].
st1w z20.d, p8, [x29, z28.d, lsl #2]
// CHECK: error: invalid operand
