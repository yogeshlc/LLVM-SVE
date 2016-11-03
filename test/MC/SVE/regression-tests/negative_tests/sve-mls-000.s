// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MLSVVVM
// Restricted predicate has range [0, 7].
mls z13.h, p8/m, z20.h, z10.h
// CHECK: error: invalid operand
