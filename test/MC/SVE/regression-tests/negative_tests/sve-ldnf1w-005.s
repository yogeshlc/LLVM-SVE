// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CLoadNF4SIZ
// Immediate out of upper bound [-8, 7].
ldnf1w z17.d, p4/z, [x0, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
