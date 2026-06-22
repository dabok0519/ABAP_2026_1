*&---------------------------------------------------------------------*
*& Report z_180_alv_opt
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_180_alv_opt.

TYPES: BEGIN OF ty_list.
        INCLUDE TYPE scarr.
TYPES: status     TYPE c,     " 신호등 (기존)
         line_color TYPE char4, " 행 색상 필드 추가 (핵심!)
       END OF ty_list.


TYPES: BEGIN OF tt_list.
         INCLUDE TYPE scarr.
TYPES:   status      TYPE c,
         line_color  TYPE char4,    " 행 전체 색상용
         cell_color  TYPE lvc_t_scol, " ★ 셀 별 색상용 (Table Type)
       END OF tt_list.



" --- 선언부 (DATA, TYPES)는 무조건 맨 위 ---
DATA: gt_list   TYPE TABLE OF ty_list,
      gs_list   TYPE ty_list,
      gs_layout TYPE slis_layout_alv.

DATA: gt_list2   TYPE TABLE OF tt_list,
      gs_list2   TYPE tt_list,
      gs_layout2 TYPE slis_layout_alv.


DATA: ls_color TYPE lvc_s_scol. " 셀 색상 정보를 담을 구조체

LOOP AT gt_list2 INTO gs_list2.
  " 1. 특정 셀(CARRID)만 노란색으로 지정
  ls_color-fname = 'ID'.   " 색을 입힐 필드명
  ls_color-color-col = '3'.    " 노란색
  ls_color-color-int = '1'.    " 강조(진하게)

  " 2. gs_list 안에 있는 cell_color 테이블에 추가
  APPEND ls_color TO gs_list2-cell_color.

  MODIFY gt_list2 FROM gs_list2 INDEX sy-tabix.
  CLEAR ls_color. " 다음 행을 위해 비워주기
ENDLOOP.


" --- 여기서부터 실행부 시작 ---
START-OF-SELECTION.

  " 1. 데이터 조회 (순서 중요! 먼저 가져와야 함)
  SELECT * FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_list.

  " 2. 데이터 가공 (조회된 데이터에 색깔/신호등 입히기)
  LOOP AT gt_list INTO gs_list.
    " 신호등 로직
    IF gs_list-currcode = 'USD'.
      gs_list-status = '3'.
    ELSE.
      gs_list-status = '2'.
    ENDIF.

    " 항공사별 행 색상 로직 (필요하신 기능)
    CASE gs_list-carrid.
      WHEN 'AA'. gs_list-line_color = 'C110'.
      WHEN 'LH'. gs_list-line_color = 'C510'.
      WHEN OTHERS. gs_list-line_color = 'C700'.
    ENDCASE.

    MODIFY gt_list FROM gs_list INDEX sy-tabix.
  ENDLOOP.

  " 3. 레이아웃 설정
  CLEAR gs_layout.
  gs_layout-lights_fieldname     = 'STATUS'.  " 신호등 필드명 (대문자 필수)
  gs_layout-info_fieldname = 'LINE_COLOR'. " 행 색상 필드명 (대문자 필수)

    " gs_layout2 대신, 기존에 쓰던 gs_layout(slis_layout_alv)을 그대로 씁니다.
gs_layout-coltab_fieldname = 'CELL_COLOR'. " 내 데이터 안에 있는 테이블 필드 이름

  " 4. ALV 호출
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout        = gs_layout
      i_structure_name = 'SCARR'
    TABLES
      t_outtab         = gt_list.
