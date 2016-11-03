// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShlVIM
// Immediate not compatible with encode/decode function.
lsl z21.b, p1/m, z21.b, #-1
// CHECK: error: immediate must be an integer in range [0, 7]
