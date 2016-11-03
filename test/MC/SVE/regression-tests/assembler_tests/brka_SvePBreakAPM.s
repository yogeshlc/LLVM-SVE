// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
brka    p15.b, p15/m, p15.b  // 00100101-00010000-01111101-11111111
// CHECK: brka    p15.b, p15/m, p15.b // encoding: [0xff,0x7d,0x10,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010000-01111101-11111111
BRKA    P15.B, P15/M, P15.B  // 00100101-00010000-01111101-11111111
// CHECK: brka    p15.b, p15/m, p15.b // encoding: [0xff,0x7d,0x10,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010000-01111101-11111111
brka    p0.b, p0/m, p0.b  // 00100101-00010000-01000000-00010000
// CHECK: brka    p0.b, p0/m, p0.b // encoding: [0x10,0x40,0x10,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010000-01000000-00010000
BRKA    P0.B, P0/M, P0.B  // 00100101-00010000-01000000-00010000
// CHECK: brka    p0.b, p0/m, p0.b // encoding: [0x10,0x40,0x10,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010000-01000000-00010000
brka    p7.b, p11/m, p13.b  // 00100101-00010000-01101101-10110111
// CHECK: brka    p7.b, p11/m, p13.b // encoding: [0xb7,0x6d,0x10,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010000-01101101-10110111
BRKA    P7.B, P11/M, P13.B  // 00100101-00010000-01101101-10110111
// CHECK: brka    p7.b, p11/m, p13.b // encoding: [0xb7,0x6d,0x10,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010000-01101101-10110111
brka    p5.b, p5/m, p10.b  // 00100101-00010000-01010101-01010101
// CHECK: brka    p5.b, p5/m, p10.b // encoding: [0x55,0x55,0x10,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010000-01010101-01010101
BRKA    P5.B, P5/M, P10.B  // 00100101-00010000-01010101-01010101
// CHECK: brka    p5.b, p5/m, p10.b // encoding: [0x55,0x55,0x10,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00010000-01010101-01010101
