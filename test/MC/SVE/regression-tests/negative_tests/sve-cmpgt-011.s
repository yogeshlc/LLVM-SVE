// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgGTVIZ
// Immediate out of upper bound [-16, 15].
cmpgt p3.d, p4/z, z18.d, #16
// CHECK: error: index must be an integer in range [-16, 15].
