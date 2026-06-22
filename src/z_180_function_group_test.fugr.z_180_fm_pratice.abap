FUNCTION Z_180_FM_PRATICE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IM_P1) TYPE  I
*"     VALUE(IM_P2) TYPE  I
*"  EXPORTING
*"     VALUE(EX_P1) TYPE  I
*"  EXCEPTIONS
*"      DIVIDE_BY_ZERO
*"      CALCULATION_ERROR
*"----------------------------------------------------------------------
  " 로직 작성
  IF im_p2 = 0.
    " 클래스 객체가 아닌 이름으로 에러를 던집니다.
    RAISE divide_by_zero.
  ELSE.
    ex_p1 = im_p1 / im_p2.
  ENDIF.

ENDFUNCTION.
