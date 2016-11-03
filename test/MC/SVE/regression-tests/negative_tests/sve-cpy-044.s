// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8DupIM
// Immediate not compatible with encode/decode function.
cpy z29.b, p11/m, #32513
// CHECK: error: immediate must be an integer in range [-128, 255] with a shift amount of 0
