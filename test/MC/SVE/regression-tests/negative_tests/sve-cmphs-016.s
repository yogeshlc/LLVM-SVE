// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgGEVIZ
// Immediate out of upper bound [0, 127].
cmphs p4.b, p1/z, z28.b, #128
// CHECK: error: immediate must be an integer in range [0, 127].
