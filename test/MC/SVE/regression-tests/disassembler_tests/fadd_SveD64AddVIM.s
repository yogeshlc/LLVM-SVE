# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x15,0x94,0xd8,0x65
# CHECK: fadd    z21.d, p5/m, z21.d, #0.5{{0*}} // encoding: [0x15,0x94,0xd8,0x65]
# CHECK-ERROR-NOT: fadd    z21.d, p5/m, z21.d, #0.5{{0*}} 
0x3f,0x9c,0xd8,0x65
# CHECK: fadd    z31.d, p7/m, z31.d, #1.0{{0*}} // encoding: [0x3f,0x9c,0xd8,0x65]
# CHECK-ERROR-NOT: fadd    z31.d, p7/m, z31.d, #1.0{{0*}} 
0x00,0x80,0xd8,0x65
# CHECK: fadd    z0.d, p0/m, z0.d, #0.5{{0*}} // encoding: [0x00,0x80,0xd8,0x65]
# CHECK-ERROR-NOT: fadd    z0.d, p0/m, z0.d, #0.5{{0*}} 
0x37,0x8c,0xd8,0x65
# CHECK: fadd    z23.d, p3/m, z23.d, #1.0{{0*}} // encoding: [0x37,0x8c,0xd8,0x65]
# CHECK-ERROR-NOT: fadd    z23.d, p3/m, z23.d, #1.0{{0*}} 
