// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16SubVVM
// Restricted predicate has range [0, 7].
sub z27.h, p8/m, z27.h, z24.h
// CHECK: error: invalid operand
