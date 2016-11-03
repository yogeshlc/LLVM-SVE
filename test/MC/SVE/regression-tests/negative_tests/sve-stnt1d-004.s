// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStoreNT8SIZ
// Immediate out of upper bound [-8, 7].
stnt1d z9.d, p2, [x10, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
