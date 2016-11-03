# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0x18,0x25
# CHECK: ptrue   p0.b, pow2 // encoding: [0x00,0xe0,0x18,0x25]
# CHECK-ERROR-NOT: ptrue   p0.b, pow2 
0x45,0xe1,0x18,0x25
# CHECK: ptrue   p5.b, vl32 // encoding: [0x45,0xe1,0x18,0x25]
# CHECK-ERROR-NOT: ptrue   p5.b, vl32 
0xa7,0xe1,0x18,0x25
# CHECK: ptrue   p7.b, vl256 // encoding: [0xa7,0xe1,0x18,0x25]
# CHECK-ERROR-NOT: ptrue   p7.b, vl256 
0xef,0xe3,0x18,0x25
# CHECK: ptrue   p15.b // encoding: [0xef,0xe3,0x18,0x25]
# CHECK-ERROR-NOT: ptrue   p15.b 
