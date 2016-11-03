// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecH16LastBV
// Restricted predicate has range [0, 7].
lastb h14, p8, z19.h
// CHECK: error: invalid operand
