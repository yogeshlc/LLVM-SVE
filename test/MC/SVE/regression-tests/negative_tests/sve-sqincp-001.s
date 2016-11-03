// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// XFAIL: *
// VecS32QIncrSCount4PS
// Source and Destination Registers must match
sqincp x20, p4.s, w21
// CHECK: error: operand must match destination register
