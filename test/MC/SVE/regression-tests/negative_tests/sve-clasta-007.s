// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecH16CondXASV
// Source and Destination Registers must match
clasta h17, p4, h18, z27.h
// CHECK: error: operand must match destination register
