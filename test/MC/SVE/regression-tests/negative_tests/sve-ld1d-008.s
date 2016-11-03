// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load8VIZ
// Immediate out of upper bound [0, 248].
ld1d z27.d, p4/z, [z1.d, #249]
// CHECK: error: index must be a multiple of 8 in range [0, 248].
