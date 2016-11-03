// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadFF2SVZ
// Restricted predicate has range [0, 7].
ldff1h z1.s, p8/z, [x28, z20.s, uxtw #1]
// CHECK: error: invalid operand
