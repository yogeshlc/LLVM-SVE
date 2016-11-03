// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MinVVM
// Source and Destination Registers must match
umin z6.h, p3/m, z7.h, z5.h
// CHECK: error: operand must match destination register
