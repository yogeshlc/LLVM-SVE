// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrDVIM
// Immediate not compatible with encode/decode function.
asrd z27.d, p3/m, z27.d, #65
// CHECK: error: immediate must be an integer in range [1, 64]
