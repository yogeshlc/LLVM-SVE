// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgGTVIZ
// Immediate out of lower bound [0, 127].
cmphi p14.h, p4/z, z9.h, #-1
// CHECK: error: immediate must be an integer in range [0, 127].
