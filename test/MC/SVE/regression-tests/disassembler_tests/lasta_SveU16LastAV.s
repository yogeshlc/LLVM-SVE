# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xb5,0x60,0x05
# CHECK: lasta   w21, p5, z10.h // encoding: [0x55,0xb5,0x60,0x05]
# CHECK-ERROR-NOT: lasta   w21, p5, z10.h 
0x00,0xa0,0x60,0x05
# CHECK: lasta   w0, p0, z0.h // encoding: [0x00,0xa0,0x60,0x05]
# CHECK-ERROR-NOT: lasta   w0, p0, z0.h 
0xff,0xbf,0x60,0x05
# CHECK: lasta   wzr, p7, z31.h // encoding: [0xff,0xbf,0x60,0x05]
# CHECK-ERROR-NOT: lasta   wzr, p7, z31.h 
0xb7,0xad,0x60,0x05
# CHECK: lasta   w23, p3, z13.h // encoding: [0xb7,0xad,0x60,0x05]
# CHECK-ERROR-NOT: lasta   w23, p3, z13.h 
