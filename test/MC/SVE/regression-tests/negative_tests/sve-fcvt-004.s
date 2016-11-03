// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecH32TruncFVM
// Restricted predicate has range [0, 7].
fcvt z15.h, p8/m, z8.s
// CHECK: error: invalid operand
