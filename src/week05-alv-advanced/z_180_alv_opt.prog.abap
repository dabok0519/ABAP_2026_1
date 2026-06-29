*&---------------------------------------------------------------------*
*& Report z_180_alv_opt
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_180_alv_opt.

TYPES: BEGIN OF ty_list.
        INCLUDE TYPE scarr.
TYPES: status     TYPE c,
         line_color TYPE char4,
       END OF ty_list.

TYPES: BEGIN OF tt_list.
         INCLUDE TYPE scarr.
TYPES:   status      TYPE c,
         line_color  TYPE char4,
         cell_color  TYPE lvc_t_scol,
       END OF tt_list.

DATA: gt_list   TYPE TABLE OF ty_list,
      gs_list   TYPE ty_list,
      gs_layout TYPE slis_layout_alv.

DATA: gt_list2   TYPE TABLE OF tt_list,
      gs_list2   TYPE tt_list,
      gs_layout2 TYPE slis_layout_alv.

DATA: ls_color TYPE lvc_s_scol.

LOOP AT gt_list2 INTO gs_list2.
  ls_color-fname = 'ID'.
  ls_color-color-col = '3'.
  ls_color-color-int = '1'.
  APPEND ls_color TO gs_list2-cell_color.
  MODIFY gt_list2 FROM gs_list2 INDEX sy-tabix.
  CLEAR ls_color.
ENDLOOP.

START-OF-SELECTION.

  SELECT * FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_list.

  LOOP AT gt_list INTO gs_list.
    IF gs_list-currcode = 'USD'.
      gs_list-status = '3'.
    ELSE.
      gs_list-status = '2'.
    ENDIF.

    CASE gs_list-carrid.
      WHEN 'AA'. gs_list-line_color = 'C110'.
      WHEN 'LH'. gs_list-line_color = 'C510'.
      WHEN OTHERS. gs_list-line_color = 'C700'.
    ENDCASE.

    MODIFY gt_list FROM gs_list INDEX sy-tabix.
  ENDLOOP.

  CLEAR gs_layout.
  gs_layout-lights_fieldname     = 'STATUS'.
  gs_layout-info_fieldname = 'LINE_COLOR'.
  gs_layout-coltab_fieldname = 'CELL_COLOR'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout        = gs_layout
      i_structure_name = 'SCARR'
    TABLES
      t_outtab         = gt_list.