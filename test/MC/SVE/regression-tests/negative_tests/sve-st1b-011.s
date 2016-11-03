// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Store1VIZ
// Immediate out of lower bound [0, 31].
st1b z1.s, p2, [z9.s, #-1]
// CHECK: error: immediate must be an integer in range [0, 31].
