// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64SubRVVM
// Source and Destination Registers must match
fsubr z30.d, p4/m, z31.d, z4.d
// CHECK: error: operand must match destination register
