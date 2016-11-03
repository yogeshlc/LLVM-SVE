// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8AbdVVM
// Restricted predicate has range [0, 7].
uabd z25.b, p8/m, z25.b, z6.b
// CHECK: error: invalid operand
