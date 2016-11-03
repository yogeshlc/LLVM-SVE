// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF2VIZ
// Restricted predicate has range [0, 7].
ldff1h z13.d, p8/z, [z24.d, #8]
// CHECK: error: invalid operand
