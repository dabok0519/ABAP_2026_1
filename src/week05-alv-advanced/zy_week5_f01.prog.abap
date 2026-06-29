*&---------------------------------------------------------------------*
*& Include zy_week5_f01
*&---------------------------------------------------------------------*
FORM get_data .

SELECT *
 INTO CORRESPONDING FIELDS OF TABLE GT_TABLE
FROM MAKT
WHERE MATNR IN s_matnr
ORDER BY MATNR.

ENDFORM.

FORM set_alv .

 IF go_grid IS INITIAL.

    PERFORM create_object.
    PERFORM set_fieldcatalog.
    PERFORM set_layout.
    PERFORM display_alv.

  ELSE.

    CALL METHOD go_grid->refresh_table_display.

  ENDIF.

ENDFORM.

FORM create_object .
CREATE OBJECT go_docking
    EXPORTING
      repid     = sy-repid
      dynnr     = sy-dynnr
      side      = 1
      extension = 2000.

  CREATE OBJECT go_grid
    EXPORTING
      i_parent = go_docking.
ENDFORM.

FORM set_fieldcatalog .
 CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
  EXPORTING
    I_STRUCTURE_NAME = 'MAKT'
  CHANGING
    CT_FIELDCAT      = GT_FCAT
  EXCEPTIONS
    INCONSISTENT_INTERFACE = 1
    PROGRAM_ERROR  = 2
    OTHERS = 3.

LOOP AT  GT_FCAT ASSIGNING FIELD-SYMBOL(<FS_FCAT>).
    CASE <FS_FCAT>-FIELDNAME.
      WHEN 'MATNR'.
        <FS_FCAT>-coltext = '자재번호'.
      WHEN 'SPRAS'.
        <FS_FCAT>-coltext = '언어'.
      WHEN 'MAKTX'.
        <FS_FCAT>-coltext = '자재설명(소)'.
      WHEN 'MAKTG'.
        <FS_FCAT>-coltext = '자재번호(대)'.
    ENDCASE.
ENDLOOP.

ENDFORM.

FORM set_layout .
CLEAR gs_layout.
  gs_layout-zebra = 'X'.
  gs_layout-cwidth_opt = 'A'.
  gs_layout-sel_mode = 'A'.
  gs_layout-grid_title = '자재 설명'.
ENDFORM.

FORM display_alv .
CALL METHOD go_grid->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout
    CHANGING
      it_outtab       = GT_TABLE
      it_fieldcatalog = gt_fcat.
ENDFORM.