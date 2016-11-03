// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecP8GenNextP
// Source and Destination Registers must match
pnext p11.b, p1, p12.b
// CHECK: error: operand must match destination register
