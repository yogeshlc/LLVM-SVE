// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStoreNT4SIZ
// Immediate out of lower bound [-8, 7].
stnt1w z6.s, p1, [x5, #-9, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
