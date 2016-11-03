// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF2VIZ
// Restricted predicate has range [0, 7].
ldff1sh z10.d, p8/z, [z15.d, #0]
// CHECK: error: invalid operand
