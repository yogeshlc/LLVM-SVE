// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store8VIZ
// Immediate out of upper bound [0, 248].
st1d z17.d, p5, [z7.d, #249]
// CHECK: error: index must be a multiple of 8 in range [0, 248].
