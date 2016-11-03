// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CmpFlgGTVIZ
// Immediate out of lower bound [0, 127].
cmphi p12.s, p4/z, z3.s, #-1
// CHECK: error: immediate must be an integer in range [0, 127].
