// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecPSetFirstActiveP
// Source and Destination Registers must match
pfirst p8.b, p2, p9.b
// CHECK: error: operand must match destination register
