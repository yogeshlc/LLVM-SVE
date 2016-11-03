// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FMSVVVM
// Restricted predicate has range [0, 7].
fmls z26.d, p8/m, z5.d, z30.d
// CHECK: error: invalid operand
