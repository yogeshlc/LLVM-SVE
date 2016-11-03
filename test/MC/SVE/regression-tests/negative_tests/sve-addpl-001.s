// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64AddPLX
// Immediate out of upper bound [-32, 31].
addpl x22, x3, #32
// CHECK: error: index must be an integer in range [-32, 31].
