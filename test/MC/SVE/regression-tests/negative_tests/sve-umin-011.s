// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MinVIX
// Immediate out of upper bound [0, 255].
umin z4.d, z4.d, #256
// CHECK: error: immediate must be an integer in range [0, 255].
