// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cntp    xzr, p15, p15.d  // 00100101-11100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.d // encoding: [0xff,0xbd,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-10111101-11111111
CNTP    XZR, P15, P15.D  // 00100101-11100000-10111101-11111111
// CHECK: cntp    xzr, p15, p15.d // encoding: [0xff,0xbd,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-10111101-11111111
cntp    x23, p11, p13.d  // 00100101-11100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.d // encoding: [0xb7,0xad,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-10101101-10110111
CNTP    X23, P11, P13.D  // 00100101-11100000-10101101-10110111
// CHECK: cntp    x23, p11, p13.d // encoding: [0xb7,0xad,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-10101101-10110111
cntp    x0, p0, p0.d  // 00100101-11100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.d // encoding: [0x00,0x80,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-10000000-00000000
CNTP    X0, P0, P0.D  // 00100101-11100000-10000000-00000000
// CHECK: cntp    x0, p0, p0.d // encoding: [0x00,0x80,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-10000000-00000000
cntp    x21, p5, p10.d  // 00100101-11100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.d // encoding: [0x55,0x95,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-10010101-01010101
CNTP    X21, P5, P10.D  // 00100101-11100000-10010101-01010101
// CHECK: cntp    x21, p5, p10.d // encoding: [0x55,0x95,0xe0,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11100000-10010101-01010101
