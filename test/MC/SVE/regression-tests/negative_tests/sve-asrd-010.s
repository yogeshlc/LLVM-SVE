// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrDVIM
// Restricted predicate has range [0, 7].
asrd z26.d, p8/m, z26.d, #1
// CHECK: error: invalid operand
