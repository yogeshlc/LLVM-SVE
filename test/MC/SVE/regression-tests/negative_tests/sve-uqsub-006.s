// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32QSubVIX
// Immediate not compatible with encode/decode function.
uqsub z28.s, z28.s, #-1
// CHECK: error: immediate must be an integer in range [0, 255] or a multiple of 256 in range [256, 65280]
