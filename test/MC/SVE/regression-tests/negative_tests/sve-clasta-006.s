// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecH16CondXASV
// Restricted predicate has range [0, 7].
clasta h22, p8, h22, z13.h
// CHECK: error: invalid operand
