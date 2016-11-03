// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MinReduceV
// Restricted predicate has range [0, 7].
uminv s24, p8, z4.s
// CHECK: error: invalid operand
