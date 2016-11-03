// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrDVIM
// Immediate not compatible with encode/decode function.
asrd z16.b, p2/m, z16.b, #9
// CHECK: error: immediate must be an integer in range [1, 8]
