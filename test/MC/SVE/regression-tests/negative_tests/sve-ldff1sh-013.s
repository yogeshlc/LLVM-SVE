// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF2VSZ
// Restricted predicate has range [0, 7].
ldff1sh z24.d, p8/z, [x14, z7.d]
// CHECK: error: invalid operand
