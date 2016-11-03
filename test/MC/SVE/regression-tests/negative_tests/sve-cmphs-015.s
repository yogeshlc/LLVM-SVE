// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgGEVIZ
// Immediate out of lower bound [0, 127].
cmphs p2.b, p3/z, z3.b, #-1
// CHECK: error: immediate must be an integer in range [0, 127].
