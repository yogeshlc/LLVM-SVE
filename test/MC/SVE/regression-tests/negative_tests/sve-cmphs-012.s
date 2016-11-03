// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CmpFlgGEVIZ
// Immediate out of upper bound [0, 127].
cmphs p10.d, p6/z, z1.d, #128
// CHECK: error: immediate must be an integer in range [0, 127].
