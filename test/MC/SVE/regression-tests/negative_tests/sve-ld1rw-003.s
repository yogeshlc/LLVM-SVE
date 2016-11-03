// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadDup4SIZ
// Restricted predicate has range [0, 7].
ld1rw z14.d, p8/z, [x30, #44]
// CHECK: error: invalid operand
