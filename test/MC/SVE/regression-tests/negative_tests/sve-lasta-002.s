// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32LastAV
// Restricted predicate has range [0, 7].
lasta s9, p8, z3.s
// CHECK: error: invalid operand
