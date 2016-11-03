// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmpne   p5.b, p5/z, z10.b, #-11  // 00100101-00010101-10010101-01010101
// CHECK: cmpne   p5.b, p5/z, z10.b, #-11 // encoding: [0x55,0x95,0x15,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010101-10010101-01010101
CMPNE   P5.B, P5/Z, Z10.B, #-11  // 00100101-00010101-10010101-01010101
// CHECK: cmpne   p5.b, p5/z, z10.b, #-11 // encoding: [0x55,0x95,0x15,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010101-10010101-01010101
cmpne   p0.b, p0/z, z0.b, #0  // 00100101-00000000-10000000-00010000
// CHECK: cmpne   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x80,0x00,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000000-10000000-00010000
CMPNE   P0.B, P0/Z, Z0.B, #0  // 00100101-00000000-10000000-00010000
// CHECK: cmpne   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x80,0x00,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00000000-10000000-00010000
cmpne   p7.b, p3/z, z13.b, #8  // 00100101-00001000-10001101-10110111
// CHECK: cmpne   p7.b, p3/z, z13.b, #8 // encoding: [0xb7,0x8d,0x08,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00001000-10001101-10110111
CMPNE   P7.B, P3/Z, Z13.B, #8  // 00100101-00001000-10001101-10110111
// CHECK: cmpne   p7.b, p3/z, z13.b, #8 // encoding: [0xb7,0x8d,0x08,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00001000-10001101-10110111
cmpne   p15.b, p7/z, z31.b, #-1  // 00100101-00011111-10011111-11111111
// CHECK: cmpne   p15.b, p7/z, z31.b, #-1 // encoding: [0xff,0x9f,0x1f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00011111-10011111-11111111
CMPNE   P15.B, P7/Z, Z31.B, #-1  // 00100101-00011111-10011111-11111111
// CHECK: cmpne   p15.b, p7/z, z31.b, #-1 // encoding: [0xff,0x9f,0x1f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00011111-10011111-11111111
