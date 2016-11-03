// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CLoadNF1SIZ
// Immediate out of upper bound [-8, 7].
ldnf1b z6.h, p2/z, [x26, #8, MUL VL]
// CHECK: error: index must be an integer in range [-8, 7].
