// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// XFAIL: *
// VecS16QDecrSCount4PS
// Source and Destination Registers must match
sqdecp x22, p10.h, w23
// CHECK: error: operand must match destination register
