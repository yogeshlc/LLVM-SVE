// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrDVIM
// Restricted predicate has range [0, 7].
asrd z17.s, p8/m, z17.s, #1
// CHECK: error: invalid operand
