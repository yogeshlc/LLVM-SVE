// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrVIM
// Restricted predicate has range [0, 7].
lsr z14.s, p8/m, z14.s, #1
// CHECK: error: invalid operand
