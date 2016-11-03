// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MovDupVI
// Immediate not compatible with encode/decode function.
mov z5.b, z14.b[256]
// CHECK: error: vector lane must be an integer in range [0, 63].
