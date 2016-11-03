// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MovIZ
// Immediate not compatible with encode/decode function.
mov z24.b, p11/z, #-32769
// CHECK: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
