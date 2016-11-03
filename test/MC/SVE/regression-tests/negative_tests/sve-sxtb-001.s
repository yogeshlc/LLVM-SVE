// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32Extnd14VM
// Restricted predicate has range [0, 7].
sxtb z18.s, p8/m, z25.s
// CHECK: error: invalid operand
