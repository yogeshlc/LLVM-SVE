// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CondXASV
// Restricted predicate has range [0, 7].
clasta w21, p8, w21, z14.h
// CHECK: error: invalid operand
