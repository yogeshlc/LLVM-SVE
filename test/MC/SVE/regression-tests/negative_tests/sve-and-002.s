// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32AndVVM
// Restricted predicate has range [0, 7].
and z17.s, p8/m, z17.s, z2.s
// CHECK: error: invalid operand
