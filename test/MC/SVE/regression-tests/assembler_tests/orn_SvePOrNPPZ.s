// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
orn     p5.b, p5/z, p10.b, p5.b  // 00100101-10000101-01010101-01010101
// CHECK: orn     p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0x85,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10000101-01010101-01010101
ORN     P5.B, P5/Z, P10.B, P5.B  // 00100101-10000101-01010101-01010101
// CHECK: orn     p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0x85,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10000101-01010101-01010101
orn     p15.b, p15/z, p15.b, p15.b  // 00100101-10001111-01111101-11111111
// CHECK: orn     p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0x8f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10001111-01111101-11111111
ORN     P15.B, P15/Z, P15.B, P15.B  // 00100101-10001111-01111101-11111111
// CHECK: orn     p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0x8f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10001111-01111101-11111111
orn     p0.b, p0/z, p0.b, p0.b  // 00100101-10000000-01000000-00010000
// CHECK: orn     p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0x80,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10000000-01000000-00010000
ORN     P0.B, P0/Z, P0.B, P0.B  // 00100101-10000000-01000000-00010000
// CHECK: orn     p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0x80,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10000000-01000000-00010000
orn     p7.b, p11/z, p13.b, p8.b  // 00100101-10001000-01101101-10110111
// CHECK: orn     p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0x88,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10001000-01101101-10110111
ORN     P7.B, P11/Z, P13.B, P8.B  // 00100101-10001000-01101101-10110111
// CHECK: orn     p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0x88,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-10001000-01101101-10110111
