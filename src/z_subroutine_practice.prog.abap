*&---------------------------------------------------------------------*
*& Report z_subroutine_practice
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_subroutine_practice.

TYPES : BEGIN OF gs_str,
        gv_val1 TYPE c,
        gv_val2 TYPE c,
        END OF gs_str.

DATA gs_var TYPE gs_str.


PERFORM write_data USING gs_var.


DATA lv_result TYPE i.

TRY.
    CALL FUNCTION 'Z_180_FM_PRATICE'
        EXPORTING
            im_p1 = 10
            im_p2 = 0
        IMPORTING
            ex_p1 = lv_result.

    CATCH cx_sy_zerodivide.
    WRITE :'나누기 오류 발생'.

ENDTRY.

IF lv_result IS NOT INITIAL.
  WRITE: / '최종 계산 결과:', lv_result.
ENDIF.


FORM write_data USING gv_str. " type gs_str.
    WRITE '서브루틴 테스트'.
ENDFORM.
