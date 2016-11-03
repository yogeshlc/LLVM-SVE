// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CondXASV
// Source and Destination Registers must match
clasta w0, p4, w1, z26.s
// CHECK: error: operand must match destination register
