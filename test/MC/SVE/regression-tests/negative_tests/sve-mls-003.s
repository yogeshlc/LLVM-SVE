// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MLSVVVM
// Restricted predicate has range [0, 7].
mls z28.b, p8/m, z21.b, z4.b
// CHECK: error: invalid operand
