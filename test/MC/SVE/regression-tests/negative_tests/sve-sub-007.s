// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16SubVVM
// Source and Destination Registers must match
sub z7.h, p1/m, z8.h, z24.h
// CHECK: error: operand must match destination register
