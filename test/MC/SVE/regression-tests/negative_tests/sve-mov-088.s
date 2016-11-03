// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MovDupVI
// Immediate not compatible with encode/decode function.
mov z3.s, z20.s[64]
// CHECK: error: vector lane must be an integer in range [0, 15].
