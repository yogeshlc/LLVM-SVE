// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecH64TruncDVM
// Restricted predicate has range [0, 7].
fcvt z3.h, p8/m, z18.d
// CHECK: error: invalid operand
