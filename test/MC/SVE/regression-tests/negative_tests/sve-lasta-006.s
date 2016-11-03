// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LastAV
// Restricted predicate has range [0, 7].
lasta x11, p8, z9.d
// CHECK: error: invalid operand
