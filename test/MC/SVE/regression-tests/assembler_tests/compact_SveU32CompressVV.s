// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
compact z31.s, p7, z31.s  // 00000101-10100001-10011111-11111111
// CHECK: compact z31.s, p7, z31.s // encoding: [0xff,0x9f,0xa1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100001-10011111-11111111
COMPACT Z31.S, P7, Z31.S  // 00000101-10100001-10011111-11111111
// CHECK: compact z31.s, p7, z31.s // encoding: [0xff,0x9f,0xa1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100001-10011111-11111111
compact z0.s, p0, z0.s  // 00000101-10100001-10000000-00000000
// CHECK: compact z0.s, p0, z0.s // encoding: [0x00,0x80,0xa1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100001-10000000-00000000
COMPACT Z0.S, P0, Z0.S  // 00000101-10100001-10000000-00000000
// CHECK: compact z0.s, p0, z0.s // encoding: [0x00,0x80,0xa1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100001-10000000-00000000
compact z23.s, p3, z13.s  // 00000101-10100001-10001101-10110111
// CHECK: compact z23.s, p3, z13.s // encoding: [0xb7,0x8d,0xa1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100001-10001101-10110111
COMPACT Z23.S, P3, Z13.S  // 00000101-10100001-10001101-10110111
// CHECK: compact z23.s, p3, z13.s // encoding: [0xb7,0x8d,0xa1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100001-10001101-10110111
compact z21.s, p5, z10.s  // 00000101-10100001-10010101-01010101
// CHECK: compact z21.s, p5, z10.s // encoding: [0x55,0x95,0xa1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100001-10010101-01010101
COMPACT Z21.S, P5, Z10.S  // 00000101-10100001-10010101-01010101
// CHECK: compact z21.s, p5, z10.s // encoding: [0x55,0x95,0xa1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100001-10010101-01010101
