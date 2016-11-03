# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0x68,0x05
# CHECK: mov     z31.h, p7/m, wsp // encoding: [0xff,0xbf,0x68,0x05]
# CHECK-ERROR-NOT: mov     z31.h, p7/m, wsp 
0xb7,0xad,0x68,0x05
# CHECK: mov     z23.h, p3/m, w13 // encoding: [0xb7,0xad,0x68,0x05]
# CHECK-ERROR-NOT: mov     z23.h, p3/m, w13 
0x00,0xa0,0x68,0x05
# CHECK: mov     z0.h, p0/m, w0 // encoding: [0x00,0xa0,0x68,0x05]
# CHECK-ERROR-NOT: mov     z0.h, p0/m, w0 
0x55,0xb5,0x68,0x05
# CHECK: mov     z21.h, p5/m, w10 // encoding: [0x55,0xb5,0x68,0x05]
# CHECK-ERROR-NOT: mov     z21.h, p5/m, w10 
