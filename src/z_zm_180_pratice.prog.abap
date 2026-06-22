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
    HIDE ls_carr-carrid. " 이 줄에 carrid 값을 몰래 숨겨둡니다!
  ENDLOOP.

AT LINE-SELECTION.
  " 더블 클릭하는 순간, 숨겨뒀던 carrid 값이 자동으로 튀어나옵니다.
  WRITE: '선택하신 항공사 ID는:', ls_carr-carrid.
