// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
trn2    p7.h, p13.h, p8.h  // 00000101-01101000-01010101-10100111
// CHECK: trn2    p7.h, p13.h, p8.h // encoding: [0xa7,0x55,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-01010101-10100111
TRN2    P7.H, P13.H, P8.H  // 00000101-01101000-01010101-10100111
// CHECK: trn2    p7.h, p13.h, p8.h // encoding: [0xa7,0x55,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-01010101-10100111
trn2    p15.h, p15.h, p15.h  // 00000101-01101111-01010101-11101111
// CHECK: trn2    p15.h, p15.h, p15.h // encoding: [0xef,0x55,0x6f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101111-01010101-11101111
TRN2    P15.H, P15.H, P15.H  // 00000101-01101111-01010101-11101111
// CHECK: trn2    p15.h, p15.h, p15.h // encoding: [0xef,0x55,0x6f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101111-01010101-11101111
trn2    p0.h, p0.h, p0.h  // 00000101-01100000-01010100-00000000
// CHECK: trn2    p0.h, p0.h, p0.h // encoding: [0x00,0x54,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-01010100-00000000
TRN2    P0.H, P0.H, P0.H  // 00000101-01100000-01010100-00000000
// CHECK: trn2    p0.h, p0.h, p0.h // encoding: [0x00,0x54,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-01010100-00000000
trn2    p5.h, p10.h, p5.h  // 00000101-01100101-01010101-01000101
// CHECK: trn2    p5.h, p10.h, p5.h // encoding: [0x45,0x55,0x65,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100101-01010101-01000101
TRN2    P5.H, P10.H, P5.H  // 00000101-01100101-01010101-01000101
// CHECK: trn2    p5.h, p10.h, p5.h // encoding: [0x45,0x55,0x65,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100101-01010101-01000101
