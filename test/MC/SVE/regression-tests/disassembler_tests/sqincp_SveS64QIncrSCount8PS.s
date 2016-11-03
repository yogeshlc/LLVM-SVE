# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x8c,0xe8,0x25
# CHECK: sqincp  x0, p0.d // encoding: [0x00,0x8c,0xe8,0x25]
# CHECK-ERROR-NOT: sqincp  x0, p0.d 
0xb7,0x8d,0xe8,0x25
# CHECK: sqincp  x23, p13.d // encoding: [0xb7,0x8d,0xe8,0x25]
# CHECK-ERROR-NOT: sqincp  x23, p13.d 
0xff,0x8d,0xe8,0x25
# CHECK: sqincp  xzr, p15.d // encoding: [0xff,0x8d,0xe8,0x25]
# CHECK-ERROR-NOT: sqincp  xzr, p15.d 
0x55,0x8d,0xe8,0x25
# CHECK: sqincp  x21, p10.d // encoding: [0x55,0x8d,0xe8,0x25]
# CHECK-ERROR-NOT: sqincp  x21, p10.d 
