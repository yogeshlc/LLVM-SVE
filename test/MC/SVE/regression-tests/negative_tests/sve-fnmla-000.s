// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FNMAVVVM
// Restricted predicate has range [0, 7].
fnmla z14.d, p8/m, z16.d, z19.d
// CHECK: error: invalid operand
