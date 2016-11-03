// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MinVIX
// Immediate out of upper bound [0, 255].
umin z18.s, z18.s, #256
// CHECK: error: immediate must be an integer in range [0, 255].
