// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrVIX
// Immediate not compatible with encode/decode function.
lsr z12.b, z18.b, #0
// CHECK: error: immediate must be an integer in range [1, 8]
