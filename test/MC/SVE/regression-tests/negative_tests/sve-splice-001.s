// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16SpliceVV
// Source and Destination Registers must match
splice z23.h, p5, z24.h, z13.h
// CHECK: error: operand must match destination register
