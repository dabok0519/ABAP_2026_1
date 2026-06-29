*&---------------------------------------------------------------------*
*& Report Z_ZM_180_PRATICE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ZM_180_PRATICE MESSAGE-ID Z180_MESSAGE.


START-OF-SELECTION.
  SELECT * FROM scarr INTO TABLE @DATA(lt_carr).
  LOOP AT lt_carr INTO DATA(ls_carr).
    WRITE: / ls_carr-carrid, ls_carr-carrname.
    HIDE ls_carr-carrid.
  ENDLOOP.

AT LINE-SELECTION.
  WRITE: '선택하신 항공사 ID는:', ls_carr-carrid.