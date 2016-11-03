# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0x35,0x05
# CHECK: mov     z21.b, p5/m, z10.b // encoding: [0x55,0xd5,0x35,0x05]
# CHECK-ERROR-NOT: mov     z21.b, p5/m, z10.b 
0xb7,0xed,0x28,0x05
# CHECK: sel     z23.b, p11, z13.b, z8.b // encoding: [0xb7,0xed,0x28,0x05]
# CHECK-ERROR-NOT: sel     z23.b, p11, z13.b, z8.b 
0x00,0xc0,0x20,0x05
# CHECK: mov     z0.b, p0/m, z0.b // encoding: [0x00,0xc0,0x20,0x05]
# CHECK-ERROR-NOT: mov     z0.b, p0/m, z0.b 
0xff,0xff,0x3f,0x05
# CHECK: mov     z31.b, p15/m, z31.b // encoding: [0xff,0xff,0x3f,0x05]
# CHECK-ERROR-NOT: mov     z31.b, p15/m, z31.b 
