// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF2VIZ
// Immediate out of lower bound [0, 62].
ldff1h z3.d, p0/z, [z28.d, #-1]
// CHECK: error: index must be a multiple of 2 in range [0, 62].
