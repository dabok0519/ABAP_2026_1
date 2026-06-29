*&---------------------------------------------------------------------*
*& Include z_thirdweek_1_user_top
*&---------------------------------------------------------------------*


" 데이터 선언
TABLES SFLIGHT.


DATA : GT_SFLIGHT TYPE TABLE OF SFLIGHT.
DATA : GS_SFLIGHT TYPE SFLIGHT.

"Selection Screen
SELECT-OPTIONS S_CARRID FOR SFLIGHT-carrid. " 1000번 스크린 생성

data : ok_code like sy-ucomm.


DATA : go_docking  TYPE REF TO cl_gui_docking_container, "도킹 컨테이너 객체
       go_grid  TYPE REF TO cl_gui_alv_grid, " grid 객체
       gt_fcat type lvc_t_fcat,
       gs_layout type lvc_s_layo.