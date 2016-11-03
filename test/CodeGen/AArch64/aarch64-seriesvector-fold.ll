; RUN: llc -mtriple=aarch64 -O2 -mattr=+sve < %s | FileCheck %s

%struct.fcmplx = type { float, float }
%struct.dcmplx = type { double, double }

define <n x 2 x %struct.fcmplx*> @fun1(%struct.fcmplx* noalias nocapture readonly %src,
                                       i64 %index) #0 {
; CHECK-LABEL: fun1
; CHECK: index [[TMP1:z[0-9]+]].d, {{x[0-9]+}}, #1
; CHECK: adr {{z[0-9]+}}.d, [{{z[0-9]+}}.d, [[TMP1]].d, lsl #3]
; CHECK: ret

  %1 = seriesvector i64 %index, 1 as <n x 2 x i64>
  %2 = getelementptr %struct.fcmplx, %struct.fcmplx* %src, <n x 2 x i64> %1

  ret <n x 2 x %struct.fcmplx*> %2
}

define <n x 2 x %struct.dcmplx*> @fun2(%struct.dcmplx* noalias nocapture readonly %src,
                                       i64 %index) #0 {
; CHECK-LABEL: fun2
; CHECK-NOT: index {{z[0-9]+}}.d, {{x[0-9]+}}, #1
; CHECK-NOT: lsl {{z[0-9]+}}.d, {{p[0-7]}}/m, {{z[0-9]+}}.d, {{z[0-9]+}}.d
; CHECK: index {{z[0-9]+}}.d, {{x[0-9]+}}, {{x[0-9]+}}
; CHECK: ret

  %1 = seriesvector i64 %index, 1 as <n x 2 x i64>
  %2 = getelementptr %struct.dcmplx, %struct.dcmplx* %src, <n x 2 x i64> %1

  ret <n x 2 x %struct.dcmplx*> %2
}
