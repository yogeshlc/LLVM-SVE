// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF4VIZ
// Immediate out of upper bound [0, 124].
ldff1w z18.d, p4/z, [z9.d, #125]
// CHECK: error: index must be a multiple of 4 in range [0, 124].
