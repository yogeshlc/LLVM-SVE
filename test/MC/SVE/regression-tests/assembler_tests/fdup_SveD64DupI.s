// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fdup    z0.d, #2.0  // 00100101-11111001-11000000-00000000
// CHECK: fmov    z0.d, #2.0{{0*}} // encoding: [0x00,0xc0,0xf9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111001-11000000-00000000
FDUP    Z0.D, #2.0  // 00100101-11111001-11000000-00000000
// CHECK: fmov    z0.d, #2.0{{0*}} // encoding: [0x00,0xc0,0xf9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111001-11000000-00000000
fdup    z23.d, #0.90625  // 00100101-11111001-11001101-10110111
// CHECK: fmov    z23.d, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xf9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111001-11001101-10110111
FDUP    Z23.D, #0.90625  // 00100101-11111001-11001101-10110111
// CHECK: fmov    z23.d, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xf9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111001-11001101-10110111
fdup    z21.d, #-13.0  // 00100101-11111001-11010101-01010101
// CHECK: fmov    z21.d, #-13.0{{0*}} // encoding: [0x55,0xd5,0xf9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111001-11010101-01010101
FDUP    Z21.D, #-13.0  // 00100101-11111001-11010101-01010101
// CHECK: fmov    z21.d, #-13.0{{0*}} // encoding: [0x55,0xd5,0xf9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111001-11010101-01010101
fdup    z31.d, #-1.9375  // 00100101-11111001-11011111-11111111
// CHECK: fmov    z31.d, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xf9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111001-11011111-11111111
FDUP    Z31.D, #-1.9375  // 00100101-11111001-11011111-11111111
// CHECK: fmov    z31.d, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xf9,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11111001-11011111-11111111
