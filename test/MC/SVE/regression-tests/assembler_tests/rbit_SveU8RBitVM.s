// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
rbit    z21.b, p5/m, z10.b  // 00000101-00100111-10010101-01010101
// CHECK: rbit    z21.b, p5/m, z10.b // encoding: [0x55,0x95,0x27,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100111-10010101-01010101
RBIT    Z21.B, P5/M, Z10.B  // 00000101-00100111-10010101-01010101
// CHECK: rbit    z21.b, p5/m, z10.b // encoding: [0x55,0x95,0x27,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100111-10010101-01010101
rbit    z0.b, p0/m, z0.b  // 00000101-00100111-10000000-00000000
// CHECK: rbit    z0.b, p0/m, z0.b // encoding: [0x00,0x80,0x27,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100111-10000000-00000000
RBIT    Z0.B, P0/M, Z0.B  // 00000101-00100111-10000000-00000000
// CHECK: rbit    z0.b, p0/m, z0.b // encoding: [0x00,0x80,0x27,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100111-10000000-00000000
rbit    z31.b, p7/m, z31.b  // 00000101-00100111-10011111-11111111
// CHECK: rbit    z31.b, p7/m, z31.b // encoding: [0xff,0x9f,0x27,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100111-10011111-11111111
RBIT    Z31.B, P7/M, Z31.B  // 00000101-00100111-10011111-11111111
// CHECK: rbit    z31.b, p7/m, z31.b // encoding: [0xff,0x9f,0x27,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100111-10011111-11111111
rbit    z23.b, p3/m, z13.b  // 00000101-00100111-10001101-10110111
// CHECK: rbit    z23.b, p3/m, z13.b // encoding: [0xb7,0x8d,0x27,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100111-10001101-10110111
RBIT    Z23.B, P3/M, Z13.B  // 00000101-00100111-10001101-10110111
// CHECK: rbit    z23.b, p3/m, z13.b // encoding: [0xb7,0x8d,0x27,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100111-10001101-10110111
