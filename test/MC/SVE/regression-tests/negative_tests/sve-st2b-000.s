// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E2Store1LSSZ
// Restricted predicate has range [0, 7].
st2b {z21.b, z22.b}, p8, [x22, x15]
// CHECK: error: invalid operand
