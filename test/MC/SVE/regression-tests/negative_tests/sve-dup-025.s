// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ExtDupVI
// Immediate not compatible with encode/decode function.
dup z22.s, z9.s[-1]
// CHECK: error: vector lane must be an integer in range [0, 15].
