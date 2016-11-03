// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgLTVIZ
// Immediate out of upper bound [0, 127].
cmplo p3.s, p4/z, z8.s, #128
// CHECK: error: immediate must be an integer in range [0, 127].
