# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x00,0x00,0x05
# CHECK: orr     z0.s, z0.s, #0x1 // encoding: [0x00,0x00,0x00,0x05]
# CHECK-ERROR-NOT: orr     z0.s, z0.s, #0x1 
0x55,0x55,0x01,0x05
# CHECK: orr     z21.h, z21.h, #0xffc1 // encoding: [0x55,0x55,0x01,0x05]
# CHECK-ERROR-NOT: orr     z21.h, z21.h, #0xffc1 
0x25,0x0e,0x00,0x05
# CHECK: orr     z5.b, z5.b, #0x81 // encoding: [0x25,0x0e,0x00,0x05]
# CHECK-ERROR-NOT: orr     z5.b, z5.b, #0x81 
0xb7,0xed,0x00,0x05
# CHECK: orr     z23.h, z23.h, #0xfff9 // encoding: [0xb7,0xed,0x00,0x05]
# CHECK-ERROR-NOT: orr     z23.h, z23.h, #0xfff9 
