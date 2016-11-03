# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0x63,0x25
# CHECK: subr    z23.h, z23.h, #27904 // encoding: [0xb7,0xed,0x63,0x25]
# CHECK-ERROR-NOT: subr    z23.h, z23.h, #27904 
0xff,0xff,0x63,0x25
# CHECK: subr    z31.h, z31.h, #65280 // encoding: [0xff,0xff,0x63,0x25]
# CHECK-ERROR-NOT: subr    z31.h, z31.h, #65280 
0x00,0xc0,0x63,0x25
# CHECK: subr    z0.h, z0.h, #0 // encoding: [0x00,0xc0,0x63,0x25]
# CHECK-ERROR-NOT: subr    z0.h, z0.h, #0 
0x55,0xd5,0x63,0x25
# CHECK: subr    z21.h, z21.h, #170 // encoding: [0x55,0xd5,0x63,0x25]
# CHECK-ERROR-NOT: subr    z21.h, z21.h, #170 
