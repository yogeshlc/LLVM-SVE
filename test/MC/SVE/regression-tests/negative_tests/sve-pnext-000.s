// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecP16GenNextP
// Source and Destination Registers must match
pnext p1.h, p11, p2.h
// CHECK: error: operand must match destination register
