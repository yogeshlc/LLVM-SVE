# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x4c,0xe0,0x04
# CHECK: index   z0.d, x0, x0 // encoding: [0x00,0x4c,0xe0,0x04]
# CHECK-ERROR-NOT: index   z0.d, x0, x0 
0xff,0x4f,0xff,0x04
# CHECK: index   z31.d, xzr, xzr // encoding: [0xff,0x4f,0xff,0x04]
# CHECK-ERROR-NOT: index   z31.d, xzr, xzr 
0xb7,0x4d,0xe8,0x04
# CHECK: index   z23.d, x13, x8 // encoding: [0xb7,0x4d,0xe8,0x04]
# CHECK-ERROR-NOT: index   z23.d, x13, x8 
0x55,0x4d,0xf5,0x04
# CHECK: index   z21.d, x10, x21 // encoding: [0x55,0x4d,0xf5,0x04]
# CHECK-ERROR-NOT: index   z21.d, x10, x21 
