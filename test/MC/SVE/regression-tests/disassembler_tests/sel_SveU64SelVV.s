# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0xe0,0x05
# CHECK: mov     z0.d, p0/m, z0.d // encoding: [0x00,0xc0,0xe0,0x05]
# CHECK-ERROR-NOT: mov     z0.d, p0/m, z0.d 
0xb7,0xed,0xe8,0x05
# CHECK: sel     z23.d, p11, z13.d, z8.d // encoding: [0xb7,0xed,0xe8,0x05]
# CHECK-ERROR-NOT: sel     z23.d, p11, z13.d, z8.d 
0x55,0xd5,0xf5,0x05
# CHECK: mov     z21.d, p5/m, z10.d // encoding: [0x55,0xd5,0xf5,0x05]
# CHECK-ERROR-NOT: mov     z21.d, p5/m, z10.d 
0xff,0xff,0xff,0x05
# CHECK: mov     z31.d, p15/m, z31.d // encoding: [0xff,0xff,0xff,0x05]
# CHECK-ERROR-NOT: mov     z31.d, p15/m, z31.d 
