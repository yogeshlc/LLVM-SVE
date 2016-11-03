// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sel     z31.h, p15, z31.h, z31.h  // 00000101-01111111-11111111-11111111
// CHECK: mov     z31.h, p15/m, z31.h // encoding: [0xff,0xff,0x7f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01111111-11111111-11111111
SEL     Z31.H, P15, Z31.H, Z31.H  // 00000101-01111111-11111111-11111111
// CHECK: mov     z31.h, p15/m, z31.h // encoding: [0xff,0xff,0x7f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01111111-11111111-11111111
sel     z23.h, p11, z13.h, z8.h  // 00000101-01101000-11101101-10110111
// CHECK: sel     z23.h, p11, z13.h, z8.h // encoding: [0xb7,0xed,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-11101101-10110111
SEL     Z23.H, P11, Z13.H, Z8.H  // 00000101-01101000-11101101-10110111
// CHECK: sel     z23.h, p11, z13.h, z8.h // encoding: [0xb7,0xed,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-11101101-10110111
sel     z21.h, p5, z10.h, z21.h  // 00000101-01110101-11010101-01010101
// CHECK: mov     z21.h, p5/m, z10.h // encoding: [0x55,0xd5,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-11010101-01010101
SEL     Z21.H, P5, Z10.H, Z21.H  // 00000101-01110101-11010101-01010101
// CHECK: mov     z21.h, p5/m, z10.h // encoding: [0x55,0xd5,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-11010101-01010101
sel     z0.h, p0, z0.h, z0.h  // 00000101-01100000-11000000-00000000
// CHECK: mov     z0.h, p0/m, z0.h // encoding: [0x00,0xc0,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-11000000-00000000
SEL     Z0.H, P0, Z0.H, Z0.H  // 00000101-01100000-11000000-00000000
// CHECK: mov     z0.h, p0/m, z0.h // encoding: [0x00,0xc0,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-11000000-00000000
