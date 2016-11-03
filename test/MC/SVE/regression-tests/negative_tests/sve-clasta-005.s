// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CondXASV
// Source and Destination Registers must match
clasta s22, p4, s23, z8.s
// CHECK: error: operand must match destination register
