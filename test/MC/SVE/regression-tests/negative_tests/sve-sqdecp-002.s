// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// XFAIL: *
// VecS64QDecrSCount4PS
// Source and Destination Registers must match
sqdecp x8, p6.d, w9
// CHECK: error: operand must match destination register
