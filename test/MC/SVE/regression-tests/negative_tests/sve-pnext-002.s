// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecP64GenNextP
// Source and Destination Registers must match
pnext p6.d, p4, p7.d
// CHECK: error: operand must match destination register
