# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x68,0x05
# CHECK: clasta  z31.h, p7, z31.h, z31.h // encoding: [0xff,0x9f,0x68,0x05]
# CHECK-ERROR-NOT: clasta  z31.h, p7, z31.h, z31.h 
0xb7,0x8d,0x68,0x05
# CHECK: clasta  z23.h, p3, z23.h, z13.h // encoding: [0xb7,0x8d,0x68,0x05]
# CHECK-ERROR-NOT: clasta  z23.h, p3, z23.h, z13.h 
0x55,0x95,0x68,0x05
# CHECK: clasta  z21.h, p5, z21.h, z10.h // encoding: [0x55,0x95,0x68,0x05]
# CHECK-ERROR-NOT: clasta  z21.h, p5, z21.h, z10.h 
0x00,0x80,0x68,0x05
# CHECK: clasta  z0.h, p0, z0.h, z0.h // encoding: [0x00,0x80,0x68,0x05]
# CHECK-ERROR-NOT: clasta  z0.h, p0, z0.h, z0.h 
