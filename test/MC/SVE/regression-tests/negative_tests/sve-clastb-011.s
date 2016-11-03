// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16VCondXBVV
// Source and Destination Registers must match
clastb z8.h, p5, z9.h, z11.h
// CHECK: error: operand must match destination register
