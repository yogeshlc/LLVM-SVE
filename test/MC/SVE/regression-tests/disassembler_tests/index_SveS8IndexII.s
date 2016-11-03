# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x41,0x28,0x04
# CHECK: index   z23.b, #13, #8 // encoding: [0xb7,0x41,0x28,0x04]
# CHECK-ERROR-NOT: index   z23.b, #13, #8 
0x00,0x40,0x20,0x04
# CHECK: index   z0.b, #0, #0 // encoding: [0x00,0x40,0x20,0x04]
# CHECK-ERROR-NOT: index   z0.b, #0, #0 
0xff,0x43,0x3f,0x04
# CHECK: index   z31.b, #-1, #-1 // encoding: [0xff,0x43,0x3f,0x04]
# CHECK-ERROR-NOT: index   z31.b, #-1, #-1 
0x55,0x41,0x35,0x04
# CHECK: index   z21.b, #10, #-11 // encoding: [0x55,0x41,0x35,0x04]
# CHECK-ERROR-NOT: index   z21.b, #10, #-11 
