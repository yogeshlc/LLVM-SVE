// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uzp2    p7.h, p13.h, p8.h  // 00000101-01101000-01001101-10100111
// CHECK: uzp2    p7.h, p13.h, p8.h // encoding: [0xa7,0x4d,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-01001101-10100111
UZP2    P7.H, P13.H, P8.H  // 00000101-01101000-01001101-10100111
// CHECK: uzp2    p7.h, p13.h, p8.h // encoding: [0xa7,0x4d,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-01001101-10100111
uzp2    p5.h, p10.h, p5.h  // 00000101-01100101-01001101-01000101
// CHECK: uzp2    p5.h, p10.h, p5.h // encoding: [0x45,0x4d,0x65,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100101-01001101-01000101
UZP2    P5.H, P10.H, P5.H  // 00000101-01100101-01001101-01000101
// CHECK: uzp2    p5.h, p10.h, p5.h // encoding: [0x45,0x4d,0x65,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100101-01001101-01000101
uzp2    p15.h, p15.h, p15.h  // 00000101-01101111-01001101-11101111
// CHECK: uzp2    p15.h, p15.h, p15.h // encoding: [0xef,0x4d,0x6f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101111-01001101-11101111
UZP2    P15.H, P15.H, P15.H  // 00000101-01101111-01001101-11101111
// CHECK: uzp2    p15.h, p15.h, p15.h // encoding: [0xef,0x4d,0x6f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101111-01001101-11101111
uzp2    p0.h, p0.h, p0.h  // 00000101-01100000-01001100-00000000
// CHECK: uzp2    p0.h, p0.h, p0.h // encoding: [0x00,0x4c,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-01001100-00000000
UZP2    P0.H, P0.H, P0.H  // 00000101-01100000-01001100-00000000
// CHECK: uzp2    p0.h, p0.h, p0.h // encoding: [0x00,0x4c,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-01001100-00000000
