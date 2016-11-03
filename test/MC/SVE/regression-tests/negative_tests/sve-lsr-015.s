// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ShrVIX
// Immediate not compatible with encode/decode function.
lsr z15.s, z24.s, #33
// CHECK: error: immediate must be an integer in range [1, 32]
