// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgGEVIZ
// Immediate out of upper bound [0, 127].
cmphs p10.h, p3/z, z2.h, #128
// CHECK: error: immediate must be an integer in range [0, 127].
