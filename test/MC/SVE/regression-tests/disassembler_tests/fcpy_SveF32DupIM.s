# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0x95,0x05
# CHECK: fmov    z21.s, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0x95,0x05]
# CHECK-ERROR-NOT: fmov    z21.s, p5/m, #-13.0{{0*}} 
0xff,0xdf,0x9f,0x05
# CHECK: fmov    z31.s, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0x9f,0x05]
# CHECK-ERROR-NOT: fmov    z31.s, p15/m, #-1.9375{{0*}} 
0x00,0xc0,0x90,0x05
# CHECK: fmov    z0.s, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0x90,0x05]
# CHECK-ERROR-NOT: fmov    z0.s, p0/m, #2.0{{0*}} 
0xb7,0xcd,0x98,0x05
# CHECK: fmov    z23.s, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0x98,0x05]
# CHECK-ERROR-NOT: fmov    z23.s, p8/m, #0.90625{{0*}} 
