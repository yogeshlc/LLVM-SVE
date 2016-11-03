// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgGTVIZ
// Immediate out of upper bound [0, 127].
cmphi p6.s, p4/z, z1.s, #128
// CHECK: error: immediate must be an integer in range [0, 127].
