// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32FNMADDVVVM
// Restricted predicate has range [0, 7].
fnmad z24.s, p8/m, z7.s, z19.s
// CHECK: error: invalid operand
