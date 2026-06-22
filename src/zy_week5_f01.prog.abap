*&---------------------------------------------------------------------*
*& Include zy_week5_f01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
FORM get_data .

SELECT *
 INTO CORRESPONDING FIELDS OF TABLE GT_TABLE
FROM MAKT
WHERE MATNR IN s_matnr
ORDER BY MATNR.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_alv .

 IF go_grid IS INITIAL.

    PERFORM create_object." 인스턴스 생성

    PERFORM set_fieldcatalog. " 필드카탈로드 생성

    PERFORM set_layout. " 레이아웃 생성

    PERFORM display_alv. " ALV 호출

  ELSE.

    CALL METHOD go_grid->refresh_table_display.

  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_object .
CREATE OBJECT go_docking " 컨테이너 생성 --> NEW CAR() 객체 생성
    EXPORTING
      repid     = sy-repid " 메서드 정의  (CAR.SPEED =50 )
      dynnr     = sy-dynnr
      side      = 1
      extension = 2000.

  CREATE OBJECT go_grid " 그리드 생성 --> NEW CAR() 객체 생성
    EXPORTING
      i_parent = go_docking.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FIELDCATALOG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fieldcatalog .
 CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
  " 해당 구조(ZSJT_FCAT_088)에 포함된 모든 필드의 정보를 자동으로 필드 카탈로그 형식에 맞게 변환하여(CT_FIELDCAT)
  " GT_FCAT에 채우는 표준 함수 모듈
  EXPORTING
    I_STRUCTURE_NAME = 'MAKT' "함수에 전달하는 입력 파라미터
  CHANGING
    CT_FIELDCAT      = GT_FCAT " 비워져있는 GT_FCAT을 함수로 넘겨 필드 카탈로그 정보를 담아 반환됨
  EXCEPTIONS
    INCONSISTENT_INTERFACE = 1 " 해당 구조와 ALV필드 카탈로그의 매핑이 맞지 않는 경우
    PROGRAM_ERROR  = 2 " 함수 내부 처리 중   프로그램 오류 발생 시
    OTHERS = 3. " 기타 예외 사항

LOOP AT  GT_FCAT ASSIGNING FIELD-SYMBOL(<FS_FCAT>). "필드 심볼은 항상 꺾쇠 괄호(<>) 사용
  " 데이터를 복사하는 과정 없이 <FS_FCAT>이 GT_FCAT의 현재 레코드를 직접 가리킴
  " 이 때문에 루프 내부에서 <FS_FCAT>을 통해 값을 변경하면 GT_FCAT의 해당 레코드가 즉시 수정
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
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
CLEAR gs_layout.

  gs_layout-zebra = 'X'. " 얼룩말 표시
  gs_layout-cwidth_opt = 'A'. " 너비 자동 조정
  gs_layout-sel_mode = 'A'. " 선택 모드
  gs_layout-grid_title = '자재 설명'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .

CALL METHOD go_grid->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout " 레이아웃

    CHANGING
      it_outtab       = GT_TABLE " 인터널 테이블
      it_fieldcatalog = gt_fcat. " 필드 카탈로그
  .

ENDFORM.
