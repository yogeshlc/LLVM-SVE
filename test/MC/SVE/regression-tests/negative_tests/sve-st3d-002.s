// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E3Store8SIZ
// Restricted predicate has range [0, 7].
st3d {z0.d, z1.d, z2.d}, p8, [x17, #14, MUL VL]
// CHECK: error: invalid operand
