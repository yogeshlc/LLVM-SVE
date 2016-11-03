// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF4YSVZ
// Restricted predicate has range [0, 7].
ldff1w z12.d, p8/z, [x6, z14.d, uxtw #2]
// CHECK: error: invalid operand
