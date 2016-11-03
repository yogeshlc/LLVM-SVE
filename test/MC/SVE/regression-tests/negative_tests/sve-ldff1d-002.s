// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF8VIZ
// Restricted predicate has range [0, 7].
ldff1d z9.d, p8/z, [z12.d, #1]
// CHECK: error: invalid operand
