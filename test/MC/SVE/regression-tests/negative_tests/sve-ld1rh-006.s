// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadDup2SIZ
// Restricted predicate has range [0, 7].
ld1rh z7.d, p8/z, [x28, #2]
// CHECK: error: invalid operand
