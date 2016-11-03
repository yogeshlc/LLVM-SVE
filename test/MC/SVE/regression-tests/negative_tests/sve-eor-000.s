// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16XorVVM
// Restricted predicate has range [0, 7].
eor z0.h, p8/m, z0.h, z0.h
// CHECK: error: invalid operand
