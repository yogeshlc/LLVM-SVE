// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8SlideVI
// Immediate out of upper bound [0, 255].
ext z22.b, z22.b, z2.b, #256
// CHECK: error: immediate must be an integer in range [0, 255].
