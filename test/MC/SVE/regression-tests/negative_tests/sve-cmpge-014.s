// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgGEVIZ
// Immediate out of lower bound [-16, 15].
cmpge p10.b, p5/z, z11.b, #-17
// CHECK: error: index must be an integer in range [-16, 15].
