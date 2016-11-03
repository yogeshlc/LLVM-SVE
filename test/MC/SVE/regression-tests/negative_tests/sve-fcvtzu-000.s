// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32_4FromFVM
// Restricted predicate has range [0, 7].
fcvtzu z25.s, p8/m, z23.s
// CHECK: error: invalid operand
