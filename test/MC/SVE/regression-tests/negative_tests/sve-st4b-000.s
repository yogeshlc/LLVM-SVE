// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E4Store1LSSZ
// Restricted predicate has range [0, 7].
st4b {z8.b, z9.b, z10.b, z11.b}, p8, [x10, x20]
// CHECK: error: invalid operand
