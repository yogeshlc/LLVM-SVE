// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadDup1SIZ
// Restricted predicate has range [0, 7].
ld1rb z17.s, p8/z, [x25, #31]
// CHECK: error: invalid operand
