// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadDup4SIZ
// Immediate out of upper bound [0, 252].
ld1rw z29.s, p2/z, [x18, #253]
// CHECK: error: index must be a multiple of 4 in range [0, 252].
