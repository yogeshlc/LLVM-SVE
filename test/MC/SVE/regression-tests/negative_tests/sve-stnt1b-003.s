// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CStoreNT1SIZ
// Immediate out of lower bound [-8, 7].
stnt1b z16.b, p0, [x12, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
