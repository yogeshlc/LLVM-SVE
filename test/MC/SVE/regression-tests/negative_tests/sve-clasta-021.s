// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CondXASV
// Source and Destination Registers must match
clasta w21, p5, w22, z6.b
// CHECK: error: operand must match destination register
