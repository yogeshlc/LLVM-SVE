// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Load4VIZ
// Immediate out of upper bound [0, 124].
ld1w z24.s, p3/z, [z25.s, #125]
// CHECK: error: index must be a multiple of 4 in range [0, 124].
