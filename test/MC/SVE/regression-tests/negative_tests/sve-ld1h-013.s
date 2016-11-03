// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load2VIZ
// Immediate out of upper bound [0, 62].
ld1h z4.s, p0/z, [z22.s, #63]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
