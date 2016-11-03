// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
zip2    p0.s, p0.s, p0.s  // 00000101-10100000-01000100-00000000
// CHECK: zip2    p0.s, p0.s, p0.s // encoding: [0x00,0x44,0xa0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100000-01000100-00000000
ZIP2    P0.S, P0.S, P0.S  // 00000101-10100000-01000100-00000000
// CHECK: zip2    p0.s, p0.s, p0.s // encoding: [0x00,0x44,0xa0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100000-01000100-00000000
zip2    p7.s, p13.s, p8.s  // 00000101-10101000-01000101-10100111
// CHECK: zip2    p7.s, p13.s, p8.s // encoding: [0xa7,0x45,0xa8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101000-01000101-10100111
ZIP2    P7.S, P13.S, P8.S  // 00000101-10101000-01000101-10100111
// CHECK: zip2    p7.s, p13.s, p8.s // encoding: [0xa7,0x45,0xa8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101000-01000101-10100111
zip2    p5.s, p10.s, p5.s  // 00000101-10100101-01000101-01000101
// CHECK: zip2    p5.s, p10.s, p5.s // encoding: [0x45,0x45,0xa5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100101-01000101-01000101
ZIP2    P5.S, P10.S, P5.S  // 00000101-10100101-01000101-01000101
// CHECK: zip2    p5.s, p10.s, p5.s // encoding: [0x45,0x45,0xa5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100101-01000101-01000101
zip2    p15.s, p15.s, p15.s  // 00000101-10101111-01000101-11101111
// CHECK: zip2    p15.s, p15.s, p15.s // encoding: [0xef,0x45,0xaf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101111-01000101-11101111
ZIP2    P15.S, P15.S, P15.S  // 00000101-10101111-01000101-11101111
// CHECK: zip2    p15.s, p15.s, p15.s // encoding: [0xef,0x45,0xaf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101111-01000101-11101111
