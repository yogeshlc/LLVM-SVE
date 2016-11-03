// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E2Store8SIZ
// Restricted predicate has range [0, 7].
st2d {z29.d, z30.d}, p8, [x27, #1, MUL VL]
// CHECK: error: invalid operand
