*&---------------------------------------------------------------------*
*& Report z_zm_180_debug_test
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_zm_180_debug_test.

DATA: gv_total   TYPE i VALUE 0,
      gv_counter TYPE i VALUE 0,
      gv_divisor TYPE i VALUE 5.

WRITE: / '--- 루프 시작 ---'.

break-POINT 1.

DO 5 TIMES.
  gv_counter = sy-index.
  gv_total   = gv_total + ( sy-index * 10 ).
enddo.

WRITE: / '--- 예외 발생 구간 ---'.
gv_divisor = 0.

TRY.
    gv_total = 100 / gv_divisor.
  CATCH cx_sy_zerodivide.
    WRITE: / '에러 발생: 0으로 나눠 수 없습니다.'.
ENDTRY.

WRITE: / '--- 모든 실습 종료 ---'.