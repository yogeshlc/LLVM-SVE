// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32LoadFF1VIZ
// Restricted predicate has range [0, 7].
ldff1sb z9.s, p8/z, [z27.s, #1]
// CHECK: error: invalid operand
