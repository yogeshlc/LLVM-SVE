// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShlVIM
// Immediate not compatible with encode/decode function.
lsl z16.s, p5/m, z16.s, #32
// CHECK: error: immediate must be an integer in range [0, 31]
