// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// XFAIL: *
// VecS64QIncrSCount4PS
// Source and Destination Registers must match
sqincp x28, p5.d, w29
// CHECK: error: operand must match destination register
