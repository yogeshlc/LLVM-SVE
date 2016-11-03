// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF2YSVZ
// Restricted predicate has range [0, 7].
ldff1h z14.d, p8/z, [x2, z21.d, uxtw #1]
// CHECK: error: invalid operand
