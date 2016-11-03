// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// XFAIL: *
// VecS8QIncrSCount4PS
// Source and Destination Registers must match
sqincp x9, p8.b, w10
// CHECK: error: operand must match destination register
