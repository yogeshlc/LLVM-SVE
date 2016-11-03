// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CmpFlgGTVIZ
// Immediate out of upper bound [0, 127].
cmphi p0.d, p0/z, z28.d, #128
// CHECK: error: immediate must be an integer in range [0, 127].
