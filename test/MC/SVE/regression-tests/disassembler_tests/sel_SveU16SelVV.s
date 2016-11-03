# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0x7f,0x05
# CHECK: mov     z31.h, p15/m, z31.h // encoding: [0xff,0xff,0x7f,0x05]
# CHECK-ERROR-NOT: mov     z31.h, p15/m, z31.h 
0xb7,0xed,0x68,0x05
# CHECK: sel     z23.h, p11, z13.h, z8.h // encoding: [0xb7,0xed,0x68,0x05]
# CHECK-ERROR-NOT: sel     z23.h, p11, z13.h, z8.h 
0x55,0xd5,0x75,0x05
# CHECK: mov     z21.h, p5/m, z10.h // encoding: [0x55,0xd5,0x75,0x05]
# CHECK-ERROR-NOT: mov     z21.h, p5/m, z10.h 
0x00,0xc0,0x60,0x05
# CHECK: mov     z0.h, p0/m, z0.h // encoding: [0x00,0xc0,0x60,0x05]
# CHECK-ERROR-NOT: mov     z0.h, p0/m, z0.h 
