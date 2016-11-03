// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MinVIX
// Source and Destination Registers must match
umin z8.b, z9.b, #0
// CHECK: error: operand must match destination register
