// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecP32GenNextP
// Source and Destination Registers must match
pnext p9.s, p9, p10.s
// CHECK: error: operand must match destination register
