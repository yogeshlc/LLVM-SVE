// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32ClzVM
// Restricted predicate has range [0, 7].
clz z12.s, p8/m, z27.s
// CHECK: error: invalid operand
