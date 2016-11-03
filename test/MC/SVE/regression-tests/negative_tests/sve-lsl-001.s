// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShlVIM
// Immediate not compatible with encode/decode function.
lsl z6.h, p1/m, z6.h, #16
// CHECK: error: immediate must be an integer in range [0, 15]
