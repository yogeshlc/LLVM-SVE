// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MinVIX
// Source and Destination Registers must match
umin z28.s, z29.s, #0
// CHECK: error: operand must match destination register
