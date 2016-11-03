// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32SubVIM
// Restricted predicate has range [0, 7].
fsub z26.s, p8/m, z26.s, #0.5
// CHECK: error: invalid operand
