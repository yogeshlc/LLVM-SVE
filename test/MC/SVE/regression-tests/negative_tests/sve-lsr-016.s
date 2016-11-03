// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrVVM
// Restricted predicate has range [0, 7].
lsr z15.s, p8/m, z15.s, z26.s
// CHECK: error: invalid operand
