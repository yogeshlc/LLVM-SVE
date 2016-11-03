// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgLTVIZ
// Immediate out of lower bound [0, 127].
cmplo p7.b, p1/z, z26.b, #-1
// CHECK: error: immediate must be an integer in range [0, 127].
