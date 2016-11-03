// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmpge   p15.d, p7/z, z31.d, #-1  // 00100101-11011111-00011111-11101111
// CHECK: cmpge   p15.d, p7/z, z31.d, #-1 // encoding: [0xef,0x1f,0xdf,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11011111-00011111-11101111
CMPGE   P15.D, P7/Z, Z31.D, #-1  // 00100101-11011111-00011111-11101111
// CHECK: cmpge   p15.d, p7/z, z31.d, #-1 // encoding: [0xef,0x1f,0xdf,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11011111-00011111-11101111
cmpge   p0.d, p0/z, z0.d, #0  // 00100101-11000000-00000000-00000000
// CHECK: cmpge   p0.d, p0/z, z0.d, #0 // encoding: [0x00,0x00,0xc0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11000000-00000000-00000000
CMPGE   P0.D, P0/Z, Z0.D, #0  // 00100101-11000000-00000000-00000000
// CHECK: cmpge   p0.d, p0/z, z0.d, #0 // encoding: [0x00,0x00,0xc0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11000000-00000000-00000000
cmpge   p7.d, p3/z, z13.d, #8  // 00100101-11001000-00001101-10100111
// CHECK: cmpge   p7.d, p3/z, z13.d, #8 // encoding: [0xa7,0x0d,0xc8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11001000-00001101-10100111
CMPGE   P7.D, P3/Z, Z13.D, #8  // 00100101-11001000-00001101-10100111
// CHECK: cmpge   p7.d, p3/z, z13.d, #8 // encoding: [0xa7,0x0d,0xc8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11001000-00001101-10100111
cmpge   p5.d, p5/z, z10.d, #-11  // 00100101-11010101-00010101-01000101
// CHECK: cmpge   p5.d, p5/z, z10.d, #-11 // encoding: [0x45,0x15,0xd5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11010101-00010101-01000101
CMPGE   P5.D, P5/Z, Z10.D, #-11  // 00100101-11010101-00010101-01000101
// CHECK: cmpge   p5.d, p5/z, z10.d, #-11 // encoding: [0x45,0x15,0xd5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11010101-00010101-01000101
