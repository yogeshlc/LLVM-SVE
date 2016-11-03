// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecH16CondXBSV
// Restricted predicate has range [0, 7].
clastb h15, p8, h15, z17.h
// CHECK: error: invalid operand
