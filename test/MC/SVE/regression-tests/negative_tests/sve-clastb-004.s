// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CondXBSV
// Restricted predicate has range [0, 7].
clastb s9, p8, s9, z12.s
// CHECK: error: invalid operand
