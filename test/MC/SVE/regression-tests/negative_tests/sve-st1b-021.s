// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store1VIZ
// Immediate out of lower bound [0, 31].
st1b z8.d, p2, [z17.d, #-1]
// CHECK: error: immediate must be an integer in range [0, 31].
