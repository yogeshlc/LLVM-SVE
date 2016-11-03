// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgLEVIZ
// Immediate out of upper bound [0, 127].
cmpls p5.s, p6/z, z30.s, #128
// CHECK: error: immediate must be an integer in range [0, 127].
