// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadDup4SIZ
// Restricted predicate has range [0, 7].
ld1rw z1.s, p8/z, [x16, #44]
// CHECK: error: invalid operand
