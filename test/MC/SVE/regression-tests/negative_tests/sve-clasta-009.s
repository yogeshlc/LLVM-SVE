// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CondXASV
// Source and Destination Registers must match
clasta w30, p2, wzr, z2.h
// CHECK: error: operand must match destination register
