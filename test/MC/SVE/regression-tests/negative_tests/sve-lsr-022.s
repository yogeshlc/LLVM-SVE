// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShrVIM
// Restricted predicate has range [0, 7].
lsr z1.d, p8/m, z1.d, #1
// CHECK: error: invalid operand
