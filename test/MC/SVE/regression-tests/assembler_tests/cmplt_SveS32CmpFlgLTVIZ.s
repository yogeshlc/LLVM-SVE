// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmplt   p15.s, p7/z, z31.s, #-1  // 00100101-10011111-00111111-11101111
// CHECK: cmplt   p15.s, p7/z, z31.s, #-1 // encoding: [0xef,0x3f,0x9f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011111-00111111-11101111
CMPLT   P15.S, P7/Z, Z31.S, #-1  // 00100101-10011111-00111111-11101111
// CHECK: cmplt   p15.s, p7/z, z31.s, #-1 // encoding: [0xef,0x3f,0x9f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10011111-00111111-11101111
cmplt   p0.s, p0/z, z0.s, #0  // 00100101-10000000-00100000-00000000
// CHECK: cmplt   p0.s, p0/z, z0.s, #0 // encoding: [0x00,0x20,0x80,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10000000-00100000-00000000
CMPLT   P0.S, P0/Z, Z0.S, #0  // 00100101-10000000-00100000-00000000
// CHECK: cmplt   p0.s, p0/z, z0.s, #0 // encoding: [0x00,0x20,0x80,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10000000-00100000-00000000
cmplt   p5.s, p5/z, z10.s, #-11  // 00100101-10010101-00110101-01000101
// CHECK: cmplt   p5.s, p5/z, z10.s, #-11 // encoding: [0x45,0x35,0x95,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010101-00110101-01000101
CMPLT   P5.S, P5/Z, Z10.S, #-11  // 00100101-10010101-00110101-01000101
// CHECK: cmplt   p5.s, p5/z, z10.s, #-11 // encoding: [0x45,0x35,0x95,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10010101-00110101-01000101
cmplt   p7.s, p3/z, z13.s, #8  // 00100101-10001000-00101101-10100111
// CHECK: cmplt   p7.s, p3/z, z13.s, #8 // encoding: [0xa7,0x2d,0x88,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10001000-00101101-10100111
CMPLT   P7.S, P3/Z, Z13.S, #8  // 00100101-10001000-00101101-10100111
// CHECK: cmplt   p7.s, p3/z, z13.s, #8 // encoding: [0xa7,0x2d,0x88,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10001000-00101101-10100111
