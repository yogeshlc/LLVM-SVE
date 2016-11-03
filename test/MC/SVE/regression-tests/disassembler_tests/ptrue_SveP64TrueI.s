# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0xd8,0x25
# CHECK: ptrue   p0.d, pow2 // encoding: [0x00,0xe0,0xd8,0x25]
# CHECK-ERROR-NOT: ptrue   p0.d, pow2 
0x45,0xe1,0xd8,0x25
# CHECK: ptrue   p5.d, vl32 // encoding: [0x45,0xe1,0xd8,0x25]
# CHECK-ERROR-NOT: ptrue   p5.d, vl32 
0xef,0xe3,0xd8,0x25
# CHECK: ptrue   p15.d // encoding: [0xef,0xe3,0xd8,0x25]
# CHECK-ERROR-NOT: ptrue   p15.d 
0xa7,0xe1,0xd8,0x25
# CHECK: ptrue   p7.d, vl256 // encoding: [0xa7,0xe1,0xd8,0x25]
# CHECK-ERROR-NOT: ptrue   p7.d, vl256 
