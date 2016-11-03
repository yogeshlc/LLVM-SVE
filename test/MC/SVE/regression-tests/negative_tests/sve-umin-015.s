// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MinVIX
// Immediate out of lower bound [0, 255].
umin z12.b, z12.b, #-1
// CHECK: error: immediate must be an integer in range [0, 255].
