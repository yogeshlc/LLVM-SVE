// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
splice  z23.s, p3, z23.s, z13.s  // 00000101-10101100-10001101-10110111
// CHECK: splice  z23.s, p3, z23.s, z13.s // encoding: [0xb7,0x8d,0xac,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101100-10001101-10110111
SPLICE  Z23.S, P3, Z23.S, Z13.S  // 00000101-10101100-10001101-10110111
// CHECK: splice  z23.s, p3, z23.s, z13.s // encoding: [0xb7,0x8d,0xac,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101100-10001101-10110111
splice  z21.s, p5, z21.s, z10.s  // 00000101-10101100-10010101-01010101
// CHECK: splice  z21.s, p5, z21.s, z10.s // encoding: [0x55,0x95,0xac,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101100-10010101-01010101
SPLICE  Z21.S, P5, Z21.S, Z10.S  // 00000101-10101100-10010101-01010101
// CHECK: splice  z21.s, p5, z21.s, z10.s // encoding: [0x55,0x95,0xac,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101100-10010101-01010101
splice  z31.s, p7, z31.s, z31.s  // 00000101-10101100-10011111-11111111
// CHECK: splice  z31.s, p7, z31.s, z31.s // encoding: [0xff,0x9f,0xac,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101100-10011111-11111111
SPLICE  Z31.S, P7, Z31.S, Z31.S  // 00000101-10101100-10011111-11111111
// CHECK: splice  z31.s, p7, z31.s, z31.s // encoding: [0xff,0x9f,0xac,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101100-10011111-11111111
splice  z0.s, p0, z0.s, z0.s  // 00000101-10101100-10000000-00000000
// CHECK: splice  z0.s, p0, z0.s, z0.s // encoding: [0x00,0x80,0xac,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101100-10000000-00000000
SPLICE  Z0.S, P0, Z0.S, Z0.S  // 00000101-10101100-10000000-00000000
// CHECK: splice  z0.s, p0, z0.s, z0.s // encoding: [0x00,0x80,0xac,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101100-10000000-00000000
