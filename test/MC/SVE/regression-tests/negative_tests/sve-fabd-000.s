// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AbdVVM
// Restricted predicate has range [0, 7].
fabd z22.d, p8/m, z22.d, z7.d
// CHECK: error: invalid operand
