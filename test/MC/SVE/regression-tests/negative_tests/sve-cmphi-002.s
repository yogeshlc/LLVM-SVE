// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgGTVIZ
// Immediate out of upper bound [0, 127].
cmphi p1.h, p6/z, z29.h, #128
// CHECK: error: immediate must be an integer in range [0, 127].
