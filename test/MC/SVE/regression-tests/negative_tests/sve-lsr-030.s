// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrVIM
// Restricted predicate has range [0, 7].
lsr z3.b, p8/m, z3.b, #1
// CHECK: error: invalid operand
