// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecB8CondXASV
// Source and Destination Registers must match
clasta b16, p3, b17, z22.b
// CHECK: error: operand must match destination register
