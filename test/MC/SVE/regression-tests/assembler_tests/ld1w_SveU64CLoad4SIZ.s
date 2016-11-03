// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ld1w    {z31.d}, p7/z, [sp, #-1, mul vl]  // 10100101-01101111-10111111-11111111
// CHECK: ld1w    {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x6f,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01101111-10111111-11111111
LD1W    {Z31.D}, P7/Z, [SP, #-1, MUL VL]  // 10100101-01101111-10111111-11111111
// CHECK: ld1w    {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x6f,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01101111-10111111-11111111
ld1w    {z21.d}, p5/z, [x10, #5, mul vl]  // 10100101-01100101-10110101-01010101
// CHECK: ld1w    {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x65,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01100101-10110101-01010101
LD1W    {Z21.D}, P5/Z, [X10, #5, MUL VL]  // 10100101-01100101-10110101-01010101
// CHECK: ld1w    {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x65,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01100101-10110101-01010101
ld1w    {z23.d}, p3/z, [x13, #-8, mul vl]  // 10100101-01101000-10101101-10110111
// CHECK: ld1w    {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x68,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01101000-10101101-10110111
LD1W    {Z23.D}, P3/Z, [X13, #-8, MUL VL]  // 10100101-01101000-10101101-10110111
// CHECK: ld1w    {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x68,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01101000-10101101-10110111
ld1w    {z0.d}, p0/z, [x0]  // 10100101-01100000-10100000-00000000
// CHECK: ld1w    {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x60,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01100000-10100000-00000000
LD1W    {Z0.D}, P0/Z, [X0]  // 10100101-01100000-10100000-00000000
// CHECK: ld1w    {z0.d}, p0/z, [x0] // encoding: [0x00,0xa0,0x60,0xa5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100101-01100000-10100000-00000000
