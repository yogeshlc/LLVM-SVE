// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8SlideVI
// Immediate out of lower bound [0, 255].
ext z18.b, z18.b, z12.b, #-1
// CHECK: error: immediate must be an integer in range [0, 255].
