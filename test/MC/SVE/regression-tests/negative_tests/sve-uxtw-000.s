// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Extnd48VM
// Restricted predicate has range [0, 7].
uxtw z3.d, p8/m, z2.d
// CHECK: error: invalid operand
