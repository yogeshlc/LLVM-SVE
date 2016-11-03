// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmple   p5.d, p5/z, z10.d, #-11  // 00100101-11010101-00110101-01010101
// CHECK: cmple   p5.d, p5/z, z10.d, #-11 // encoding: [0x55,0x35,0xd5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11010101-00110101-01010101
CMPLE   P5.D, P5/Z, Z10.D, #-11  // 00100101-11010101-00110101-01010101
// CHECK: cmple   p5.d, p5/z, z10.d, #-11 // encoding: [0x55,0x35,0xd5,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11010101-00110101-01010101
cmple   p15.d, p7/z, z31.d, #-1  // 00100101-11011111-00111111-11111111
// CHECK: cmple   p15.d, p7/z, z31.d, #-1 // encoding: [0xff,0x3f,0xdf,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11011111-00111111-11111111
CMPLE   P15.D, P7/Z, Z31.D, #-1  // 00100101-11011111-00111111-11111111
// CHECK: cmple   p15.d, p7/z, z31.d, #-1 // encoding: [0xff,0x3f,0xdf,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11011111-00111111-11111111
cmple   p7.d, p3/z, z13.d, #8  // 00100101-11001000-00101101-10110111
// CHECK: cmple   p7.d, p3/z, z13.d, #8 // encoding: [0xb7,0x2d,0xc8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11001000-00101101-10110111
CMPLE   P7.D, P3/Z, Z13.D, #8  // 00100101-11001000-00101101-10110111
// CHECK: cmple   p7.d, p3/z, z13.d, #8 // encoding: [0xb7,0x2d,0xc8,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11001000-00101101-10110111
cmple   p0.d, p0/z, z0.d, #0  // 00100101-11000000-00100000-00010000
// CHECK: cmple   p0.d, p0/z, z0.d, #0 // encoding: [0x10,0x20,0xc0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11000000-00100000-00010000
CMPLE   P0.D, P0/Z, Z0.D, #0  // 00100101-11000000-00100000-00010000
// CHECK: cmple   p0.d, p0/z, z0.d, #0 // encoding: [0x10,0x20,0xc0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11000000-00100000-00010000
