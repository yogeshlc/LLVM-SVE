// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16AndVVM
// Source and Destination Registers must match
and z19.h, p2/m, z20.h, z18.h
// CHECK: error: operand must match destination register
