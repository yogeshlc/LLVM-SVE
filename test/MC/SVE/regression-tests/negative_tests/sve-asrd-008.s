// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrDVIM
// Immediate not compatible with encode/decode function.
asrd z9.d, p1/m, z9.d, #0
// CHECK: error: immediate must be an integer in range [1, 64]
