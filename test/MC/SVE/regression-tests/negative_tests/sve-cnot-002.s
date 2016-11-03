// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64NotVM
// Restricted predicate has range [0, 7].
cnot z16.d, p8/m, z7.d
// CHECK: error: invalid operand
