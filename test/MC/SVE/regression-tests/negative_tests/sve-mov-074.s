// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MovI
// Immediate not compatible with encode/decode function.
mov z2.b, #32513
// CHECK: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
