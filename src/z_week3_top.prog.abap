*&---------------------------------------------------------------------*
*& Include z_week3_top
*&---------------------------------------------------------------------*

" 테이블 선언
TABLES SFLIGHT.


DATA : GT_SFLIGHT TYPE TABLE OF SFLIGHT.
DATA : GS_sFLIGHT TYPE SFLIGHT.


SELECT-OPTIONS S_CARRID FOR SFLIGHT-S_CARRID.


DATA : go_docking  TYPE REF TO cl_gui_docking_container,
       go_grid  TYPE REF TO cl_gui_alv_grid,
       gt_fcat type lvc_t_fcat, " DDIC에 정의되어 있는 TABLE TYPE을 참조하였기 때문에 TYPE을 쓰더라도 INTERNAL TABLE로 복사됨
       gs_layout type lvc_s_layo.
