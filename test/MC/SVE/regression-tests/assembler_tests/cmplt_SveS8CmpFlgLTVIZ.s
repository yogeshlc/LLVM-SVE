// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmplt   p7.b, p3/z, z13.b, #8  // 00100101-00001000-00101101-10100111
// CHECK: cmplt   p7.b, p3/z, z13.b, #8 // encoding: [0xa7,0x2d,0x08,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00001000-00101101-10100111
CMPLT   P7.B, P3/Z, Z13.B, #8  // 00100101-00001000-00101101-10100111
// CHECK: cmplt   p7.b, p3/z, z13.b, #8 // encoding: [0xa7,0x2d,0x08,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00001000-00101101-10100111
cmplt   p15.b, p7/z, z31.b, #-1  // 00100101-00011111-00111111-11101111
// CHECK: cmplt   p15.b, p7/z, z31.b, #-1 // encoding: [0xef,0x3f,0x1f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00011111-00111111-11101111
CMPLT   P15.B, P7/Z, Z31.B, #-1  // 00100101-00011111-00111111-11101111
// CHECK: cmplt   p15.b, p7/z, z31.b, #-1 // encoding: [0xef,0x3f,0x1f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00011111-00111111-11101111
cmplt   p5.b, p5/z, z10.b, #-11  // 00100101-00010101-00110101-01000101
// CHECK: cmplt   p5.b, p5/z, z10.b, #-11 // encoding: [0x45,0x35,0x15,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010101-00110101-01000101
CMPLT   P5.B, P5/Z, Z10.B, #-11  // 00100101-00010101-00110101-01000101
// CHECK: cmplt   p5.b, p5/z, z10.b, #-11 // encoding: [0x45,0x35,0x15,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010101-00110101-01000101
cmplt   p0.b, p0/z, z0.b, #0  // 00100101-00000000-00100000-00000000
// CHECK: cmplt   p0.b, p0/z, z0.b, #0 // encoding: [0x00,0x20,0x00,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000000-00100000-00000000
CMPLT   P0.B, P0/Z, Z0.B, #0  // 00100101-00000000-00100000-00000000
// CHECK: cmplt   p0.b, p0/z, z0.b, #0 // encoding: [0x00,0x20,0x00,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000000-00100000-00000000
