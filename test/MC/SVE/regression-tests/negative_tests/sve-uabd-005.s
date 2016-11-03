// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AbdVVM
// Source and Destination Registers must match
uabd z4.d, p0/m, z5.d, z3.d
// CHECK: error: operand must match destination register
