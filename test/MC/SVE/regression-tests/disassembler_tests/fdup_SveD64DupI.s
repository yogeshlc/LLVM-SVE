# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0xf9,0x25
# CHECK: fmov    z0.d, #2.0{{0*}} // encoding: [0x00,0xc0,0xf9,0x25]
# CHECK-ERROR-NOT: fmov    z0.d, #2.0{{0*}} 
0xb7,0xcd,0xf9,0x25
# CHECK: fmov    z23.d, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xf9,0x25]
# CHECK-ERROR-NOT: fmov    z23.d, #0.90625{{0*}} 
0x55,0xd5,0xf9,0x25
# CHECK: fmov    z21.d, #-13.0{{0*}} // encoding: [0x55,0xd5,0xf9,0x25]
# CHECK-ERROR-NOT: fmov    z21.d, #-13.0{{0*}} 
0xff,0xdf,0xf9,0x25
# CHECK: fmov    z31.d, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xf9,0x25]
# CHECK-ERROR-NOT: fmov    z31.d, #-1.9375{{0*}} 
