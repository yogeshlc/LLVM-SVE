// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FNMSVVVM
// Restricted predicate has range [0, 7].
fnmls z4.s, p8/m, z24.s, z30.s
// CHECK: error: invalid operand
