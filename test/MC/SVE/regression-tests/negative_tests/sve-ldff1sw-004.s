// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF4VIZ
// Immediate out of upper bound [0, 124].
ldff1sw z23.d, p5/z, [z2.d, #125]
// CHECK: error: index must be a multiple of 4 in range [0, 124].
