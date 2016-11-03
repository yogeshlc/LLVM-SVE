// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
clasta  z23.d, p3, z23.d, z13.d  // 00000101-11101000-10001101-10110111
// CHECK: clasta  z23.d, p3, z23.d, z13.d // encoding: [0xb7,0x8d,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-10001101-10110111
CLASTA  Z23.D, P3, Z23.D, Z13.D  // 00000101-11101000-10001101-10110111
// CHECK: clasta  z23.d, p3, z23.d, z13.d // encoding: [0xb7,0x8d,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-10001101-10110111
clasta  z21.d, p5, z21.d, z10.d  // 00000101-11101000-10010101-01010101
// CHECK: clasta  z21.d, p5, z21.d, z10.d // encoding: [0x55,0x95,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-10010101-01010101
CLASTA  Z21.D, P5, Z21.D, Z10.D  // 00000101-11101000-10010101-01010101
// CHECK: clasta  z21.d, p5, z21.d, z10.d // encoding: [0x55,0x95,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-10010101-01010101
clasta  z31.d, p7, z31.d, z31.d  // 00000101-11101000-10011111-11111111
// CHECK: clasta  z31.d, p7, z31.d, z31.d // encoding: [0xff,0x9f,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-10011111-11111111
CLASTA  Z31.D, P7, Z31.D, Z31.D  // 00000101-11101000-10011111-11111111
// CHECK: clasta  z31.d, p7, z31.d, z31.d // encoding: [0xff,0x9f,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-10011111-11111111
clasta  z0.d, p0, z0.d, z0.d  // 00000101-11101000-10000000-00000000
// CHECK: clasta  z0.d, p0, z0.d, z0.d // encoding: [0x00,0x80,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-10000000-00000000
CLASTA  Z0.D, P0, Z0.D, Z0.D  // 00000101-11101000-10000000-00000000
// CHECK: clasta  z0.d, p0, z0.d, z0.d // encoding: [0x00,0x80,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-10000000-00000000
