// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1sb   {z0.s}, p0/z, [x0, z0.s, sxtw]  // 10000100-01000000-00000000-00000000
// CHECK: ld1sb   {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x00,0x40,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01000000-00000000-00000000
LD1SB   {Z0.S}, P0/Z, [X0, Z0.S, SXTW]  // 10000100-01000000-00000000-00000000
// CHECK: ld1sb   {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x00,0x40,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01000000-00000000-00000000
ld1sb   {z31.s}, p7/z, [sp, z31.s, sxtw]  // 10000100-01011111-00011111-11111111
// CHECK: ld1sb   {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x1f,0x5f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01011111-00011111-11111111
LD1SB   {Z31.S}, P7/Z, [SP, Z31.S, SXTW]  // 10000100-01011111-00011111-11111111
// CHECK: ld1sb   {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x1f,0x5f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01011111-00011111-11111111
ld1sb   {z21.s}, p5/z, [x10, z21.s, sxtw]  // 10000100-01010101-00010101-01010101
// CHECK: ld1sb   {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x15,0x55,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01010101-00010101-01010101
LD1SB   {Z21.S}, P5/Z, [X10, Z21.S, SXTW]  // 10000100-01010101-00010101-01010101
// CHECK: ld1sb   {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x15,0x55,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01010101-00010101-01010101
ld1sb   {z23.s}, p3/z, [x13, z8.s, sxtw]  // 10000100-01001000-00001101-10110111
// CHECK: ld1sb   {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x0d,0x48,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01001000-00001101-10110111
LD1SB   {Z23.S}, P3/Z, [X13, Z8.S, SXTW]  // 10000100-01001000-00001101-10110111
// CHECK: ld1sb   {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x0d,0x48,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-01001000-00001101-10110111
