// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MovDupVI
// Immediate not compatible with encode/decode function.
mov z9.d, z13.d[32]
// CHECK: error: vector lane must be an integer in range [0, 7].
