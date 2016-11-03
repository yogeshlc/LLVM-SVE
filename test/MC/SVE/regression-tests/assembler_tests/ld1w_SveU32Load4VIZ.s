// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1w    {z0.s}, p0/z, [z0.s]  // 10000101-00100000-11000000-00000000
// CHECK: ld1w    {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xc0,0x20,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00100000-11000000-00000000
LD1W    {Z0.S}, P0/Z, [Z0.S]  // 10000101-00100000-11000000-00000000
// CHECK: ld1w    {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xc0,0x20,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00100000-11000000-00000000
ld1w    {z23.s}, p3/z, [z13.s, #32]  // 10000101-00101000-11001101-10110111
// CHECK: ld1w    {z23.s}, p3/z, [z13.s, #32] // encoding: [0xb7,0xcd,0x28,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00101000-11001101-10110111
LD1W    {Z23.S}, P3/Z, [Z13.S, #32]  // 10000101-00101000-11001101-10110111
// CHECK: ld1w    {z23.s}, p3/z, [z13.s, #32] // encoding: [0xb7,0xcd,0x28,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00101000-11001101-10110111
ld1w    {z21.s}, p5/z, [z10.s, #84]  // 10000101-00110101-11010101-01010101
// CHECK: ld1w    {z21.s}, p5/z, [z10.s, #84] // encoding: [0x55,0xd5,0x35,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00110101-11010101-01010101
LD1W    {Z21.S}, P5/Z, [Z10.S, #84]  // 10000101-00110101-11010101-01010101
// CHECK: ld1w    {z21.s}, p5/z, [z10.s, #84] // encoding: [0x55,0xd5,0x35,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00110101-11010101-01010101
ld1w    {z31.s}, p7/z, [z31.s, #124]  // 10000101-00111111-11011111-11111111
// CHECK: ld1w    {z31.s}, p7/z, [z31.s, #124] // encoding: [0xff,0xdf,0x3f,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00111111-11011111-11111111
LD1W    {Z31.S}, P7/Z, [Z31.S, #124]  // 10000101-00111111-11011111-11111111
// CHECK: ld1w    {z31.s}, p7/z, [z31.s, #124] // encoding: [0xff,0xdf,0x3f,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00111111-11011111-11111111
