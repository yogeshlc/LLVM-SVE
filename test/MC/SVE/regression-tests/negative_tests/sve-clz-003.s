// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ClzVM
// Restricted predicate has range [0, 7].
clz z8.b, p8/m, z23.b
// CHECK: error: invalid operand
