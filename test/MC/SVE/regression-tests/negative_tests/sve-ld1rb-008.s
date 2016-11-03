// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadDup1SIZ
// Immediate out of upper bound [0, 63].
ld1rb z30.d, p5/z, [x9, #64]
// CHECK: error: index must be in range [0, 63].
