// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CntVM
// Restricted predicate has range [0, 7].
cnt z21.s, p8/m, z5.s
// CHECK: error: invalid operand
