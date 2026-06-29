*&---------------------------------------------------------------------*
*& Include z_thirdweek_1_o01
*&---------------------------------------------------------------------*

INCLUDE z_thirdweek_1_status_0100o01.
MODULE set_alv OUTPUT.
   IF go_grid is Initial.
        CREATE OBJECT go_docking
            exporting
                repid = sy-repid
                dynnr = sy-dynnr
                side = 1
                extension = 2000.

        CREATE OBJECT go_grid
            exporting
                i_parent = go_docking.
    ENDIF.


DATA : ls_fcat type lvc_s_fcat.
REFRESH gt_fcat.

CLEAR : ls_fcat.
ls_fcat-fieldname = 'CARRID'.
ls_fcat-coltext = '코드'.
ls_fcat-just = 'C'.
ls_fcat-OUTPUTLEN = 4.
APPEND ls_fcat TO gt_fcat.


CLEAR : ls_fcat.
ls_fcat-fieldname = 'CONNID'.
ls_fcat-coltext = '번호'.
ls_fcat-just = 'C'.
ls_fcat-OUTPUTLEN = 4.
APPEND ls_fcat TO gt_fcat.


CLEAR : ls_fcat.
ls_fcat-fieldname = 'FLDATE'.
ls_fcat-coltext = '비행 날짜'.
ls_fcat-just = 'C'.
ls_fcat-OUTPUTLEN = 12.
APPEND ls_fcat TO gt_fcat.


CLEAR : GS_LAYOUT.
gs_layout-zebra = 'X'.
gs_layout-cwidth_opt = 'X'.
gs_layout-sel_mode = 'A'.
gs_layout-grid_title = '항공편 목록'.

CALL METHOD go_grid->set_table_for_first_display
  EXPORTING
    i_structure_name = 'SFLIGHT'
    is_layout        = gs_layout
    i_save           = 'X'
    i_default        = ' '
  CHANGING
    it_outtab        = GT_SFLIGHT
    IT_FIELDCATALOG  = gt_fcat.


ENDMODULE.