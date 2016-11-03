// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CondXBSV
// Source and Destination Registers must match
clastb d6, p6, d7, z7.d
// CHECK: error: operand must match destination register
