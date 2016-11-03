// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MaxVVM
// Restricted predicate has range [0, 7].
umax z22.s, p8/m, z22.s, z5.s
// CHECK: error: invalid operand
