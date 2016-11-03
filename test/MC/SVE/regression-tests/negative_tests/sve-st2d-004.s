// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E2Store8SIZ
// Immediate out of upper bound [-16, 14].
st2d {z25.d, z26.d}, p2, [x22, #15, MUL VL]
// CHECK: error: index must be a multiple of 2 in range [-16, 14].
