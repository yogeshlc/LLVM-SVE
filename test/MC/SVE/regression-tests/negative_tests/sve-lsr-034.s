// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrVVM
// Restricted predicate has range [0, 7].
lsr z13.b, p8/m, z13.b, z25.b
// CHECK: error: invalid operand
