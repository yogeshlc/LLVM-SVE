// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E4Store8SIZ
// Restricted predicate has range [0, 7].
st4d {z29.d, z30.d, z31.d, z0.d}, p8, [x15, #2, MUL VL]
// CHECK: error: invalid operand
