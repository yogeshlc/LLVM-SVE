// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrDVIM
// Restricted predicate has range [0, 7].
asrd z25.h, p8/m, z25.h, #1
// CHECK: error: invalid operand
