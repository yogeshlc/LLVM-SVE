; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; CLS
;

define <n x 16 x i8> @cls_i8(<n x 16 x i8> %a, <n x 16 x i1> %pg, <n x 16 x i8> %b) {
; CHECK-LABEL: cls_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: cls z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.cls.nxv16i8(<n x 16 x i8> %a,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @cls_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: cls_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: cls z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.cls.nxv8i16(<n x 8 x i16> %a,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @cls_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: cls_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: cls z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.cls.nxv4i32(<n x 4 x i32> %a,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @cls_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: cls_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: cls z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.cls.nxv2i64(<n x 2 x i64> %a,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; CLZ
;

define <n x 16 x i8> @clz_i8(<n x 16 x i8> %a, <n x 16 x i1> %pg, <n x 16 x i8> %b) {
; CHECK-LABEL: clz_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: clz z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.clz.nxv16i8(<n x 16 x i8> %a,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @clz_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: clz_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: clz z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.clz.nxv8i16(<n x 8 x i16> %a,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @clz_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: clz_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: clz z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.clz.nxv4i32(<n x 4 x i32> %a,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @clz_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: clz_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: clz z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.clz.nxv2i64(<n x 2 x i64> %a,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; CNT
;

define <n x 16 x i8> @cnt_i8(<n x 16 x i8> %a, <n x 16 x i1> %pg, <n x 16 x i8> %b) {
; CHECK-LABEL: cnt_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: cnt z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.cnt.nxv16i8(<n x 16 x i8> %a,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @cnt_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: cnt_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: cnt z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.cnt.nxv8i16(<n x 8 x i16> %a,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @cnt_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: cnt_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: cnt z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.cnt.nxv4i32(<n x 4 x i32> %a,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @cnt_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: cnt_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: cnt z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.cnt.nxv2i64(<n x 2 x i64> %a,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

define <n x 8 x i16> @cnt_f16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: cnt_f16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: cnt z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.cnt.nxv8f16(<n x 8 x i16> %a,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x half> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @cnt_f32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: cnt_f32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: cnt z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.cnt.nxv4f32(<n x 4 x i32> %a,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @cnt_f64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: cnt_f64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: cnt z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.cnt.nxv2f64(<n x 2 x i64> %a,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

declare <n x 16 x i8> @llvm.aarch64.sve.cls.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.cls.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.cls.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.cls.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.clz.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.clz.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.clz.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.clz.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.cnt.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.cnt.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.cnt.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.cnt.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 8 x i16> @llvm.aarch64.sve.cnt.nxv8f16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x half>)
declare <n x 4 x i32> @llvm.aarch64.sve.cnt.nxv4f32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x i64> @llvm.aarch64.sve.cnt.nxv2f64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x double>)
