// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlVIM
// Immediate not compatible with encode/decode function.
lsl z5.s, p3/m, z5.s, #-1
// CHECK: error: immediate must be an integer in range [0, 31]
