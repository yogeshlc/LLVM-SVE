// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Rev2V
// Restricted predicate has range [0, 7].
revh z26.s, p8/m, z29.s
// CHECK: error: invalid operand
