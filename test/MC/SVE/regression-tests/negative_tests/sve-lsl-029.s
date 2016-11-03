// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShlVIM
// Immediate not compatible with encode/decode function.
lsl z17.b, p5/m, z17.b, #8
// CHECK: error: immediate must be an integer in range [0, 7]
