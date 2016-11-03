// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShlVIM
// Immediate not compatible with encode/decode function.
lsl z12.d, p0/m, z12.d, #-1
// CHECK: error: immediate must be an integer in range [0, 63]
