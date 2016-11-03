// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Extnd28VM
// Restricted predicate has range [0, 7].
uxth z27.d, p8/m, z5.d
// CHECK: error: invalid operand
