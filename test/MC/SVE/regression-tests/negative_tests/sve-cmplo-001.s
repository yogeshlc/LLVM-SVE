// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgLTVIZ
// Immediate out of lower bound [0, 127].
cmplo p0.h, p0/z, z27.h, #-1
// CHECK: error: immediate must be an integer in range [0, 127].
