// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CondXASV
// Source and Destination Registers must match
clasta d26, p0, d27, z6.d
// CHECK: error: operand must match destination register
