// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MovDupVI
// Immediate not compatible with encode/decode function.
mov z1.h, z30.h[128]
// CHECK: error: vector lane must be an integer in range [0, 31].
