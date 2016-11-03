// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16LastBV
// Restricted predicate has range [0, 7].
lastb w6, p8, z3.h
// CHECK: error: invalid operand
