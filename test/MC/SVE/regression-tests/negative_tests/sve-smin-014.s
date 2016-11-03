// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64MinVVM
// Source and Destination Registers must match
smin z7.d, p6/m, z8.d, z4.d
// CHECK: error: operand must match destination register
