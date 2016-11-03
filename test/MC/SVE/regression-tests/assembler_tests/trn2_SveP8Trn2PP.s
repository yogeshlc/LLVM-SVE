// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
trn2    p15.b, p15.b, p15.b  // 00000101-00101111-01010101-11101111
// CHECK: trn2    p15.b, p15.b, p15.b // encoding: [0xef,0x55,0x2f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101111-01010101-11101111
TRN2    P15.B, P15.B, P15.B  // 00000101-00101111-01010101-11101111
// CHECK: trn2    p15.b, p15.b, p15.b // encoding: [0xef,0x55,0x2f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101111-01010101-11101111
trn2    p5.b, p10.b, p5.b  // 00000101-00100101-01010101-01000101
// CHECK: trn2    p5.b, p10.b, p5.b // encoding: [0x45,0x55,0x25,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100101-01010101-01000101
TRN2    P5.B, P10.B, P5.B  // 00000101-00100101-01010101-01000101
// CHECK: trn2    p5.b, p10.b, p5.b // encoding: [0x45,0x55,0x25,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100101-01010101-01000101
trn2    p7.b, p13.b, p8.b  // 00000101-00101000-01010101-10100111
// CHECK: trn2    p7.b, p13.b, p8.b // encoding: [0xa7,0x55,0x28,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101000-01010101-10100111
TRN2    P7.B, P13.B, P8.B  // 00000101-00101000-01010101-10100111
// CHECK: trn2    p7.b, p13.b, p8.b // encoding: [0xa7,0x55,0x28,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101000-01010101-10100111
trn2    p0.b, p0.b, p0.b  // 00000101-00100000-01010100-00000000
// CHECK: trn2    p0.b, p0.b, p0.b // encoding: [0x00,0x54,0x20,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100000-01010100-00000000
TRN2    P0.B, P0.B, P0.B  // 00000101-00100000-01010100-00000000
// CHECK: trn2    p0.b, p0.b, p0.b // encoding: [0x00,0x54,0x20,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100000-01010100-00000000
