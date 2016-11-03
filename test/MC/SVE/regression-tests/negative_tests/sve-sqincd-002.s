// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// XFAIL: *
// VecS64QIncrVL4SI
// Source and Destination Registers must match
sqincd x28, w29, pow2, MUL #1
// CHECK: error: operand must match destination register
