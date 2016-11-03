// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrVIX
// Immediate not compatible with encode/decode function.
lsr z27.b, z3.b, #9
// CHECK: error: immediate must be an integer in range [1, 8]
