// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FMAVVVM
// Restricted predicate has range [0, 7].
fmla z21.d, p8/m, z27.d, z17.d
// CHECK: error: invalid operand
