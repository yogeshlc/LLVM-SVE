// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CmpFlgGEVIZ
// Immediate out of lower bound [-16, 15].
cmpge p4.d, p4/z, z8.d, #-17
// CHECK: error: index must be an integer in range [-16, 15].
