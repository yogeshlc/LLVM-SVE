// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1sh   {z0.s}, p0/z, [x0, z0.s, sxtw]  // 10000100-11000000-00000000-00000000
// CHECK: ld1sh   {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x00,0xc0,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-11000000-00000000-00000000
LD1SH   {Z0.S}, P0/Z, [X0, Z0.S, SXTW]  // 10000100-11000000-00000000-00000000
// CHECK: ld1sh   {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x00,0xc0,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-11000000-00000000-00000000
ld1sh   {z23.s}, p3/z, [x13, z8.s, sxtw]  // 10000100-11001000-00001101-10110111
// CHECK: ld1sh   {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x0d,0xc8,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-11001000-00001101-10110111
LD1SH   {Z23.S}, P3/Z, [X13, Z8.S, SXTW]  // 10000100-11001000-00001101-10110111
// CHECK: ld1sh   {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x0d,0xc8,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-11001000-00001101-10110111
ld1sh   {z21.s}, p5/z, [x10, z21.s, sxtw]  // 10000100-11010101-00010101-01010101
// CHECK: ld1sh   {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x15,0xd5,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-11010101-00010101-01010101
LD1SH   {Z21.S}, P5/Z, [X10, Z21.S, SXTW]  // 10000100-11010101-00010101-01010101
// CHECK: ld1sh   {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x15,0xd5,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-11010101-00010101-01010101
ld1sh   {z31.s}, p7/z, [sp, z31.s, sxtw]  // 10000100-11011111-00011111-11111111
// CHECK: ld1sh   {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x1f,0xdf,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-11011111-00011111-11111111
LD1SH   {Z31.S}, P7/Z, [SP, Z31.S, SXTW]  // 10000100-11011111-00011111-11111111
// CHECK: ld1sh   {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x1f,0xdf,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-11011111-00011111-11111111
