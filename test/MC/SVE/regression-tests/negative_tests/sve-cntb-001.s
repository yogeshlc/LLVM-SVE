// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CountVLSI
// Immediate not compatible with encode/decode function.
cntb x24, pow2, MUL #17
// CHECK: error: immediate must be an integer in range [1, 16]
