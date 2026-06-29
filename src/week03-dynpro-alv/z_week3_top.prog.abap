*&---------------------------------------------------------------------*
*& Include z_week3_top
*&---------------------------------------------------------------------*

TABLES SFLIGHT.

DATA : GT_SFLIGHT TYPE TABLE OF SFLIGHT.
DATA : GS_sFLIGHT TYPE SFLIGHT.

SELECT-OPTIONS S_CARRID FOR SFLIGHT-S_CARRID.

DATA : go_docking  TYPE REF TO cl_gui_docking_container,
       go_grid  TYPE REF TO cl_gui_alv_grid,
       gt_fcat type lvc_t_fcat,
       gs_layout type lvc_s_layo.