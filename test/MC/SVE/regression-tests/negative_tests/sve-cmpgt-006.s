// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgGTVIZ
// Immediate out of upper bound [-16, 15].
cmpgt p10.s, p2/z, z7.s, #16
// CHECK: error: index must be an integer in range [-16, 15].
