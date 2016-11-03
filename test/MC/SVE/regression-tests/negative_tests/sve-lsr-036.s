// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrVWM
// Restricted predicate has range [0, 7].
lsr z17.b, p8/m, z17.b, z0.d
// CHECK: error: invalid operand
