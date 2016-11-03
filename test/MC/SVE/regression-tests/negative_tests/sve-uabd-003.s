// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32AbdVVM
// Source and Destination Registers must match
uabd z14.s, p6/m, z15.s, z6.s
// CHECK: error: operand must match destination register
