*&---------------------------------------------------------------------*
*& Include z_thirdweek_1_o01
*&---------------------------------------------------------------------*

INCLUDE z_thirdweek_1_status_0100o01.
MODULE set_alv OUTPUT.
   IF go_grid is Initial.
        CREATE OBJECT go_docking "컨테이너 생성
            exporting
                repid = sy-repid
                dynnr = sy-dynnr
                side = 1  "어느 벽에 붙힐거야 ?
                extension = 2000. " 화면 크기를 초기에 얼마로 설정할거야 ?

        CREATE OBJECT go_grid
            exporting
                i_parent = go_docking.
    ENDIF.


" 필드 카탈로그 수동 생성
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
gs_layout-zebra = 'X'. " 얼룩말 표시
gs_layout-cwidth_opt = 'X'. "너비 자동 조절 (컬럼 너비 최적화)
gs_layout-sel_mode = 'A'. " 셀 선택 모드 A-> 행 전체 선택 가능
gs_layout-grid_title = '항공편 목록'. "ALV 상단 제목

" 메소드 호출
CALL METHOD go_grid->set_table_for_first_display
  EXPORTING
    i_structure_name = 'SFLIGHT'
    is_layout        = gs_layout   " <--- 방금 만든 설정값 전달!
    i_save           = 'X' " 사용자가 레이아웃을 저장할 수 있는 권한을 설정 ( X : 공용 )
    i_default        = ' ' " 사용자가 정의한 기본 레이아웃을 우선 적용할지 여부
  CHANGING
    it_outtab        = GT_SFLIGHT " 화면에 뿌릴 진짜 데이터가 담긴 인터널 테이블 정의
    IT_FIELDCATALOG  = gt_fcat.  " 컬럼의 이름, 길이, 합계 여부, 수정 가능 여부 등을 일일이 설정


ENDMODULE.
