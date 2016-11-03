// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E3Store1LSSZ
// Restricted predicate has range [0, 7].
st3b {z1.b, z2.b, z3.b}, p8, [x30, x2]
// CHECK: error: invalid operand
