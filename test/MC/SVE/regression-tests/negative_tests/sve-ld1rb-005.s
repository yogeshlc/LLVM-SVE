// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadDup1SIZ
// Immediate out of upper bound [0, 63].
ld1rb z23.s, p4/z, [x25, #64]
// CHECK: error: index must be in range [0, 63].
