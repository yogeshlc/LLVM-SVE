// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MinReduceV
// Restricted predicate has range [0, 7].
uminv h26, p8, z11.h
// CHECK: error: invalid operand
