// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8Prefetch1LSS
// Restricted predicate has range [0, 7].
prfb pldl3keep, p8, [x2, x10]
// CHECK: error: invalid operand
