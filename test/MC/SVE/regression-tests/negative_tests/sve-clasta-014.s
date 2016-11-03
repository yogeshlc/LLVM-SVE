// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32VCondXAVV
// Restricted predicate has range [0, 7].
clasta z11.s, p8, z11.s, z26.s
// CHECK: error: invalid operand
