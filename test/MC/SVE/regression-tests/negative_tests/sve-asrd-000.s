// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrDVIM
// Immediate not compatible with encode/decode function.
asrd z8.h, p4/m, z8.h, #0
// CHECK: error: immediate must be an integer in range [1, 16]
