// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FromU4VM
// Restricted predicate has range [0, 7].
ucvtf z30.d, p8/m, z27.s
// CHECK: error: invalid operand
