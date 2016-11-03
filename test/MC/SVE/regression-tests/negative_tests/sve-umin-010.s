// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MinVIX
// Immediate out of lower bound [0, 255].
umin z14.d, z14.d, #-1
// CHECK: error: immediate must be an integer in range [0, 255].
