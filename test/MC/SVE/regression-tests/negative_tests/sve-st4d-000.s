// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E4Store8LSSZ
// Restricted predicate has range [0, 7].
st4d {z24.d, z25.d, z26.d, z27.d}, p8, [x18, x2, lsl #3]
// CHECK: error: invalid operand
