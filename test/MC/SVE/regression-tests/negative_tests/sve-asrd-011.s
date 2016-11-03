// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrDVIM
// Source and Destination Registers must match
asrd z3.d, p6/m, z4.d, #1
// CHECK: error: operand must match destination register
