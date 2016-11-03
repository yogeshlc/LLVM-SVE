; RUN: llc -O3 -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

declare <n x 16 x i8> @llvm.ctpop.nxv16i8(<n x 16 x i8>)
declare <n x 8 x i16> @llvm.ctpop.nxv8i16(<n x 8 x i16>)
declare <n x 4 x i32> @llvm.ctpop.nxv4i32(<n x 4 x i32>)
declare <n x 2 x i64> @llvm.ctpop.nxv2i64(<n x 2 x i64>)

define <n x 16 x i8> @ctpop_b(<n x 16 x i8> %a) {
; CHECK-LABEL: ctpop_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK: cnt z0.b, [[PG]]/m, z0.b
; CHECK: ret

  %res = call <n x 16 x i8> @llvm.ctpop.nxv16i8(<n x 16 x i8> %a)
  ret <n x 16 x i8> %res
}

define <n x 8 x i16> @ctpop_h(<n x 8 x i16> %a) {
; CHECK-LABEL: ctpop_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK: cnt z0.h, [[PG]]/m, z0.h
; CHECK: ret

  %res = call <n x 8 x i16> @llvm.ctpop.nxv8i16(<n x 8 x i16> %a)
  ret <n x 8 x i16> %res
}

define <n x 4 x i32> @ctpop_s(<n x 4 x i32> %a) {
; CHECK-LABEL: ctpop_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK: cnt z0.s, [[PG]]/m, z0.s
; CHECK: ret

  %res = call <n x 4 x i32> @llvm.ctpop.nxv4i32(<n x 4 x i32> %a)
  ret <n x 4 x i32> %res
}

define <n x 2 x i64> @ctpop_d(<n x 2 x i64> %a) {
; CHECK-LABEL: ctpop_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK: cnt z0.d, [[PG]]/m, z0.d
; CHECK: ret

  %res = call <n x 2 x i64> @llvm.ctpop.nxv2i64(<n x 2 x i64> %a)
  ret <n x 2 x i64> %res
}
