// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF1VIZ
// Immediate out of lower bound [0, 31].
ldff1b z0.d, p4/z, [z16.d, #-1]
// CHECK: error: immediate must be an integer in range [0, 31].
