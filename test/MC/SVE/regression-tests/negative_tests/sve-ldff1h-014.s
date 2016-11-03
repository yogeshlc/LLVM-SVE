// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF2VSZ
// Restricted predicate has range [0, 7].
ldff1h z27.d, p8/z, [x27, z23.d]
// CHECK: error: invalid operand
