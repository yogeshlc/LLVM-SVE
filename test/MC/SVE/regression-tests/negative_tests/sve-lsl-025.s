// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShlVIX
// Immediate not compatible with encode/decode function.
lsl z0.d, z22.d, #64
// CHECK: error: immediate must be an integer in range [0, 63]
