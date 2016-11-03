// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32AbdVVM
// Restricted predicate has range [0, 7].
uabd z4.s, p8/m, z4.s, z1.s
// CHECK: error: invalid operand
