// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrDVIM
// Immediate not compatible with encode/decode function.
asrd z27.s, p2/m, z27.s, #0
// CHECK: error: immediate must be an integer in range [1, 32]
