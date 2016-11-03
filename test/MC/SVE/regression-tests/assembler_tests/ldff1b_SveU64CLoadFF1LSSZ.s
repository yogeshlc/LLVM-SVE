// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
ldff1b  {z31.d}, p7/z, [sp, xzr]  // 10100100-01111111-01111111-11111111
// CHECK: ldff1b  {z31.d}, p7/z, [sp, xzr] // encoding: [0xff,0x7f,0x7f,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01111111-01111111-11111111
LDFF1B  {Z31.D}, P7/Z, [SP, XZR]  // 10100100-01111111-01111111-11111111
// CHECK: ldff1b  {z31.d}, p7/z, [sp, xzr] // encoding: [0xff,0x7f,0x7f,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01111111-01111111-11111111
ldff1b  {z21.d}, p5/z, [x10, x21]  // 10100100-01110101-01110101-01010101
// CHECK: ldff1b  {z21.d}, p5/z, [x10, x21] // encoding: [0x55,0x75,0x75,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01110101-01110101-01010101
LDFF1B  {Z21.D}, P5/Z, [X10, X21]  // 10100100-01110101-01110101-01010101
// CHECK: ldff1b  {z21.d}, p5/z, [x10, x21] // encoding: [0x55,0x75,0x75,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01110101-01110101-01010101
ldff1b  {z23.d}, p3/z, [x13, x8]  // 10100100-01101000-01101101-10110111
// CHECK: ldff1b  {z23.d}, p3/z, [x13, x8] // encoding: [0xb7,0x6d,0x68,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01101000-01101101-10110111
LDFF1B  {Z23.D}, P3/Z, [X13, X8]  // 10100100-01101000-01101101-10110111
// CHECK: ldff1b  {z23.d}, p3/z, [x13, x8] // encoding: [0xb7,0x6d,0x68,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01101000-01101101-10110111
ldff1b  {z0.d}, p0/z, [x0, x0]  // 10100100-01100000-01100000-00000000
// CHECK: ldff1b  {z0.d}, p0/z, [x0, x0] // encoding: [0x00,0x60,0x60,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01100000-01100000-00000000
LDFF1B  {Z0.D}, P0/Z, [X0, X0]  // 10100100-01100000-01100000-00000000
// CHECK: ldff1b  {z0.d}, p0/z, [x0, x0] // encoding: [0x00,0x60,0x60,0xa4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10100100-01100000-01100000-00000000
