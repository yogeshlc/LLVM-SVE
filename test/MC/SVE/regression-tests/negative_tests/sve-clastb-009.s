// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CondXBSV
// Source and Destination Registers must match
clastb w26, p3, w27, z3.h
// CHECK: error: operand must match destination register
