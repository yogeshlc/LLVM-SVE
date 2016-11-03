// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF64TruncDVM
// Restricted predicate has range [0, 7].
fcvt z12.s, p8/m, z27.d
// CHECK: error: invalid operand
