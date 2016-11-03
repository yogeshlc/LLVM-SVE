# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0x69,0x05
# CHECK: clastb  z21.h, p5, z21.h, z10.h // encoding: [0x55,0x95,0x69,0x05]
# CHECK-ERROR-NOT: clastb  z21.h, p5, z21.h, z10.h 
0xb7,0x8d,0x69,0x05
# CHECK: clastb  z23.h, p3, z23.h, z13.h // encoding: [0xb7,0x8d,0x69,0x05]
# CHECK-ERROR-NOT: clastb  z23.h, p3, z23.h, z13.h 
0xff,0x9f,0x69,0x05
# CHECK: clastb  z31.h, p7, z31.h, z31.h // encoding: [0xff,0x9f,0x69,0x05]
# CHECK-ERROR-NOT: clastb  z31.h, p7, z31.h, z31.h 
0x00,0x80,0x69,0x05
# CHECK: clastb  z0.h, p0, z0.h, z0.h // encoding: [0x00,0x80,0x69,0x05]
# CHECK-ERROR-NOT: clastb  z0.h, p0, z0.h, z0.h 
