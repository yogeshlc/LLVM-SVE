// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8NotVM
// Restricted predicate has range [0, 7].
cnot z27.b, p8/m, z12.b
// CHECK: error: invalid operand
