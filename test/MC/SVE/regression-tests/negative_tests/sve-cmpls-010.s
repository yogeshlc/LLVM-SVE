// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CmpFlgLEVIZ
// Immediate out of upper bound [0, 127].
cmpls p10.d, p3/z, z24.d, #128
// CHECK: error: immediate must be an integer in range [0, 127].
