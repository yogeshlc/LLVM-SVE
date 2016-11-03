// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CLoadFF1LSSZ
// Restricted predicate has range [0, 7].
ldff1b z23.s, p8/z, [x21, x30]
// CHECK: error: invalid operand
