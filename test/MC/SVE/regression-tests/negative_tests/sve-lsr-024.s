// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShrVIX
// Immediate not compatible with encode/decode function.
lsr z0.d, z12.d, #0
// CHECK: error: immediate must be an integer in range [1, 64]
