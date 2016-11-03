// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadDup2SIZ
// Restricted predicate has range [0, 7].
ld1rh z21.s, p8/z, [x8, #31]
// CHECK: error: invalid operand
