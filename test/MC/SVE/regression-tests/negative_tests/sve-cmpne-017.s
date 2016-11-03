// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgNEVVZ
// Restricted predicate has range [0, 7].
cmpne p8.b, p8/z, z9.b, z28.b
// CHECK: error: invalid operand
