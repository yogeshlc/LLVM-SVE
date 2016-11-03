# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xb5,0x98,0x04
# CHECK: cls     z21.s, p5/m, z10.s // encoding: [0x55,0xb5,0x98,0x04]
# CHECK-ERROR-NOT: cls     z21.s, p5/m, z10.s 
0xb7,0xad,0x98,0x04
# CHECK: cls     z23.s, p3/m, z13.s // encoding: [0xb7,0xad,0x98,0x04]
# CHECK-ERROR-NOT: cls     z23.s, p3/m, z13.s 
0xff,0xbf,0x98,0x04
# CHECK: cls     z31.s, p7/m, z31.s // encoding: [0xff,0xbf,0x98,0x04]
# CHECK-ERROR-NOT: cls     z31.s, p7/m, z31.s 
0x00,0xa0,0x98,0x04
# CHECK: cls     z0.s, p0/m, z0.s // encoding: [0x00,0xa0,0x98,0x04]
# CHECK-ERROR-NOT: cls     z0.s, p0/m, z0.s 
