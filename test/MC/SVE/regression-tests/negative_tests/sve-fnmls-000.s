// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FNMSVVVM
// Restricted predicate has range [0, 7].
fnmls z5.d, p8/m, z7.d, z23.d
// CHECK: error: invalid operand
