// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MinVVM
// Source and Destination Registers must match
umin z14.d, p4/m, z15.d, z1.d
// CHECK: error: operand must match destination register
