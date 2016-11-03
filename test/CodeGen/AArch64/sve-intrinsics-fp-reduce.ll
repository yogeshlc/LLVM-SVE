; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

;
; FADDA
;

define float @fadda_f32(<n x 4 x i1> %pg, float %init, <n x 4 x float> %a) {
; CHECK-LABEL: fadda_f32:
; CHECK: fadda s0, p0, s0, z1.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.adda.nxv4f32(<n x 4 x i1> %pg,
                                                   float %init,
                                                   <n x 4 x float> %a)
  ret float %res
}

define double @fadda_f64(<n x 2 x i1> %pg, double %init, <n x 2 x double> %a) {
; CHECK-LABEL: fadda_f64:
; CHECK: fadda d0, p0, d0, z1.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.adda.nxv2f64(<n x 2 x i1> %pg,
                                                    double %init,
                                                    <n x 2 x double> %a)
  ret double %res
}

;
; FADDV
;

define float @faddv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: faddv_f32:
; CHECK: faddv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.addv.nxv4f32(<n x 4 x i1> %pg,
                                                  <n x 4 x float> %a)
  ret float %res
}

define double @faddv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: faddv_f64:
; CHECK: faddv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.addv.nxv2f64(<n x 2 x i1> %pg,
                                                    <n x 2 x double> %a)
  ret double %res
}

;
; FMAXNMV
;

define float @fmaxnmv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmaxnmv_f32:
; CHECK: fmaxnmv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.maxnmv.nxv4f32(<n x 4 x i1> %pg,
                                                     <n x 4 x float> %a)
  ret float %res
}

define double @fmaxnmv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmaxnmv_f64:
; CHECK: fmaxnmv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.maxnmv.nxv2f64(<n x 2 x i1> %pg,
                                                      <n x 2 x double> %a)
  ret double %res
}

;
; FMAXV
;

define float @fmaxv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fmaxv_f32:
; CHECK: fmaxv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.maxv.nxv4f32(<n x 4 x i1> %pg,
                                                   <n x 4 x float> %a)
  ret float %res
}

define double @fmaxv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fmaxv_f64:
; CHECK: fmaxv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.maxv.nxv2f64(<n x 2 x i1> %pg,
                                                    <n x 2 x double> %a)
  ret double %res
}

;
; FMINNMV
;

define float @fminnmv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fminnmv_f32:
; CHECK: fminnmv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.minnmv.nxv4f32(<n x 4 x i1> %pg,
                                                     <n x 4 x float> %a)
  ret float %res
}

define double @fminnmv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fminnmv_f64:
; CHECK: fminnmv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.minnmv.nxv2f64(<n x 2 x i1> %pg,
                                                      <n x 2 x double> %a)
  ret double %res
}

;
; FMINV
;

define float @fminv_f32(<n x 4 x i1> %pg, <n x 4 x float> %a) {
; CHECK-LABEL: fminv_f32:
; CHECK: fminv s0, p0, z0.s
; CHECK-NEXT: ret
  %res = call float @llvm.aarch64.sve.minv.nxv4f32(<n x 4 x i1> %pg,
                                                   <n x 4 x float> %a)
  ret float %res
}

define double @fminv_f64(<n x 2 x i1> %pg, <n x 2 x double> %a) {
; CHECK-LABEL: fminv_f64:
; CHECK: fminv d0, p0, z0.d
; CHECK-NEXT: ret
  %res = call double @llvm.aarch64.sve.minv.nxv2f64(<n x 2 x i1> %pg,
                                                    <n x 2 x double> %a)
  ret double %res
}

declare float @llvm.aarch64.sve.adda.nxv4f32(<n x 4 x i1>, float, <n x 4 x float>)
declare double @llvm.aarch64.sve.adda.nxv2f64(<n x 2 x i1>, double, <n x 2 x double>)

declare float @llvm.aarch64.sve.addv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.addv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)

declare float @llvm.aarch64.sve.maxnmv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.maxnmv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)

declare float @llvm.aarch64.sve.maxv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.maxv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)

declare float @llvm.aarch64.sve.minnmv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.minnmv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)

declare float @llvm.aarch64.sve.minv.nxv4f32(<n x 4 x i1>, <n x 4 x float>)
declare double @llvm.aarch64.sve.minv.nxv2f64(<n x 2 x i1>, <n x 2 x double>)
