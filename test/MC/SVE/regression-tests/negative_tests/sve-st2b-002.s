// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E2Store1SIZ
// Restricted predicate has range [0, 7].
st2b {z15.b, z16.b}, p8, [x7, #3, MUL VL]
// CHECK: error: invalid operand
