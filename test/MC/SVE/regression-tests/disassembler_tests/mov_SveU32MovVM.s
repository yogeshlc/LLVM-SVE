# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0xa0,0x05
# CHECK: mov     z0.s, p0/m, z0.s // encoding: [0x00,0xc0,0xa0,0x05]
# CHECK-ERROR-NOT: mov     z0.s, p0/m, z0.s 
0xff,0xff,0xbf,0x05
# CHECK: mov     z31.s, p15/m, z31.s // encoding: [0xff,0xff,0xbf,0x05]
# CHECK-ERROR-NOT: mov     z31.s, p15/m, z31.s 
0x55,0xd5,0xb5,0x05
# CHECK: mov     z21.s, p5/m, z10.s // encoding: [0x55,0xd5,0xb5,0x05]
# CHECK-ERROR-NOT: mov     z21.s, p5/m, z10.s 
