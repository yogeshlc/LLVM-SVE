// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MaxVVM
// Restricted predicate has range [0, 7].
umax z1.b, p8/m, z1.b, z21.b
// CHECK: error: invalid operand
