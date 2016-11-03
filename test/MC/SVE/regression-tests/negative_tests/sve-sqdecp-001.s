// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// XFAIL: *
// VecS32QDecrSCount4PS
// Source and Destination Registers must match
sqdecp x2, p14.s, w3
// CHECK: error: operand must match destination register
