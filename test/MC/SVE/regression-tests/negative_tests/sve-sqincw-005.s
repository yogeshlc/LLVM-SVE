// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32QIncrVLVI
// Immediate not compatible with encode/decode function.
sqincw z23.s, pow2, MUL #-1
// CHECK: error: immediate must be an integer in range [1, 16]
