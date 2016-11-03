// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E3Store8LSSZ
// Restricted predicate has range [0, 7].
st3d {z26.d, z27.d, z28.d}, p8, [x27, x26, lsl #3]
// CHECK: error: invalid operand
