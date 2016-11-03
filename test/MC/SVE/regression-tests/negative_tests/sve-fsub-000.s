// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64SubVIM
// Restricted predicate has range [0, 7].
fsub z9.d, p8/m, z9.d, #0.5
// CHECK: error: invalid operand
