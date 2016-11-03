// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clastb  w0, p0, w0, z0.s  // 00000101-10110001-10100000-00000000
// CHECK: clastb  w0, p0, w0, z0.s // encoding: [0x00,0xa0,0xb1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110001-10100000-00000000
CLASTB  W0, P0, W0, Z0.S  // 00000101-10110001-10100000-00000000
// CHECK: clastb  w0, p0, w0, z0.s // encoding: [0x00,0xa0,0xb1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110001-10100000-00000000
clastb  w23, p3, w23, z13.s  // 00000101-10110001-10101101-10110111
// CHECK: clastb  w23, p3, w23, z13.s // encoding: [0xb7,0xad,0xb1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110001-10101101-10110111
CLASTB  W23, P3, W23, Z13.S  // 00000101-10110001-10101101-10110111
// CHECK: clastb  w23, p3, w23, z13.s // encoding: [0xb7,0xad,0xb1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110001-10101101-10110111
clastb  w21, p5, w21, z10.s  // 00000101-10110001-10110101-01010101
// CHECK: clastb  w21, p5, w21, z10.s // encoding: [0x55,0xb5,0xb1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110001-10110101-01010101
CLASTB  W21, P5, W21, Z10.S  // 00000101-10110001-10110101-01010101
// CHECK: clastb  w21, p5, w21, z10.s // encoding: [0x55,0xb5,0xb1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110001-10110101-01010101
clastb  wzr, p7, wzr, z31.s  // 00000101-10110001-10111111-11111111
// CHECK: clastb  wzr, p7, wzr, z31.s // encoding: [0xff,0xbf,0xb1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110001-10111111-11111111
CLASTB  WZR, P7, WZR, Z31.S  // 00000101-10110001-10111111-11111111
// CHECK: clastb  wzr, p7, wzr, z31.s // encoding: [0xff,0xbf,0xb1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110001-10111111-11111111
