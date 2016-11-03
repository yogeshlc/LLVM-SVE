// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// XFAIL: *
// VecS16QIncrSCount4PS
// Source and Destination Registers must match
sqincp x27, p6.h, w28
// CHECK: error: operand must match destination register
