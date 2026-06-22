*&---------------------------------------------------------------------*
*& Report z_180_firstweek
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_180_firstweek.
*&---------------------------------------------------------------------*
*& 1주차: 26-1 ERP 연구회 회원 정보를 다루는 ABAP 기초 실습 프로그램입니다.
*&---------------------------------------------------------------------*


*--------------------------------------------------------------------*
* 1. 단일 변수 선언 및 값 할당
* 숫자형 데이터 하나와 텍스트형 데이터 하나를 생성하고, 임의의 값을 넣어주세요.
* Keyword(DATA, C 타입은 Length를 적절하게 지정해주기)
* cl_demo_output=>display (변수/스트럭처/인터널테이블명)을 사용해서 값이 잘 들어갔는지 확인
* ㄴ> WRITE보다 간편하고 보기좋은 출력방식이에요. (cl_demo_output 클래스의 display 메소드-> 객제지향개념 참고만!)
*--------------------------------------------------------------------*

DATA gv_num TYPE i.
DATA gv_name TYPE c LENGTH 10.

gv_num = '60211289'.
gv_name = '권민성'.

cl_demo_output=>display( | { gv_num } / { gv_name } | ).
*cl_demo_output=>display() : 하나의 변수만 출력 가능 ( 여러 개를 출력 하고 싶으면 문자열 연결 사용 )



*--------------------------------------------------------------------*
* 2. Structure TYPE을 선언 (Structure(구조체)는 BEGIN OF, END OF 사용)
* -> ERP 연구회 회원 정보 구조를 정의해봅시다.
*    멤버ID(member_id: 숫자), 이름(name: 문자), 역할(role: 문자)구조를 가지도록 선언
*--------------------------------------------------------------------*
TYPES : BEGIN OF gv_str,
        gv_member_id TYPE i,
        gv_name TYPE c LENGTH 10,
        gv_role TYPE c LENGTH 10,
        END OF gv_str.


*--------------------------------------------------------------------*
* 3. 2번에서 만든 Structure TYPE을 참조하여 스트럭처와 인터널 테이블 생성
*    인터널 테이블은 Standard Table를 사용하고, WITH NON-UNIQUE KEY 구문을 사용하시오.
*    NON-UNIQUE KEY의 의미: 키를 명시적으로 지정해줌 + 유일성 X, 중복가능
*   (KEY 지정을 안해주면 자동으로 모든 C,N 타입 필드를 KEY로 자동 지정.)
"   [왜 Standard 테이블은 UNIQUE KEY 사용이 안될까?-> 생각해보고 찾아보기]
*--------------------------------------------------------------------*
DATA it_table TYPE TABLE OF gv_str WITH NON-UNIQUE KEY gv_member_id.


*--------------------------------------------------------------------*
* 4. LIKE 문을 사용해서 또 다른 스트럭처와 인터널 테이블을 생성해봅시다.
* 인터널 테이블을 Like로 복사하면 인터널 테이블이 생성된다. 테이블의 구조만 가져와서 스트럭쳐를 생성할 때는,
* LIKE LINE OF 구문을 사용
*--------------------------------------------------------------------*
DATA gv_str2 LIKE LINE OF it_table.
DATA gv_itab LIKE it_table.

*--------------------------------------------------------------------*
* 5. 3번에서 만든 Structure에 값을 담아 봅시다.
* 인터널 테이블을 다루려면 스트럭처를 사용해야 합니다.
* 스트럭처에 접근할 때 ABAP은 Hyphen (-)을 이용합니다.
* 스트럭처 이름-변수(필드)이름 = '넣을 값'.
* 넣을 값은 타입에 맞는 값으로 임의로 넣어보세요.
* cl_demo_output=>display_data( 스트럭쳐 이름 ). 으로 잘 담겼는지 확인해봅시다
*--------------------------------------------------------------------*


gv_str2-gv_member_id = '60211289'.
gv_str2-gv_name = '권민성'.
gv_str2-gv_role = '학회원'.

cl_demo_output=>display_data( gv_str2 ).
CLEAR gv_str2.
*--------------------------------------------------------------------*
*6. 5번에서 연습한 것처럼 스트럭처에 값 담고 인터널 테이블에 추가 (APPEND)
* -> 정성균, 조장 이름, 자신 이름 3명의 정보를 3번에서 만든 Internal table에 추가합니다.
* 인터널 테이블은 스트럭쳐를 통해 핸들링합니다.
* 스트럭쳐에 값을 담고 APPEND, CLEAR 스트럭쳐 / 담고 APPEND, CLEAR 스트럭쳐...
* 넣을 값은 제공된 표를 참고하시오.
* 클리어를 해야하는 이유 생각해보기.
*cl_demo_output=>display( 변수/스트럭처/인터널테이블명 ) 통해서 값이 잘 들어갔는지 확인.
*--------------------------------------------------------------------*


gv_str2-gv_member_id = '600000001'.
gv_str2-gv_name = '정성균'.
gv_str2-gv_role = '학회장'.
APPEND gv_str2 TO it_table.
CLEAR gv_str2.

gv_str2-gv_member_id = '60000002'.
gv_str2-gv_name = '김재혁'.
gv_str2-gv_role = '조장님'.
APPEND gv_str2 TO it_table.
CLEAR gv_str2.

gv_str2-gv_member_id = '60000003'.
gv_str2-gv_name = '권민성'.
gv_str2-gv_role = '학회원'.
APPEND gv_str2 TO it_table.
CLEAR gv_str2.

 cl_demo_output=>display( it_table ).
 " alv : 현업에서 사용
 " cl_demo_output=>display( ) : 간단하게 보여주는 용도 ( table까지도 출력 가능 !  )
 " write out=>display :  ( table이 출력 불가능하고 한 행씩 값을 출력

*--------------------------------------------------------------------*
* 6-1. 인터널 테이블 값 수정 (MODIFY)
* -> 2026-1학기가 시작되어 연구회 구성원의 역할이 변동되었습니다.
* 팀원의 role->O조 조원, 조장의 role -> O조 조장
* 다음과 같은 변동을 Internal Table에 반영하시오.
* MODIFY __ FROM ___ TRANSPORTING __ WHERE __ = ' '
*cl_demo_output=>display( 변수/스트럭처/인터널테이블명 ) 통해서 참고 사진과 비교해보기.
*--------------------------------------------------------------------*

gv_str2-gv_role = '1조 조장님 '.
MODIFY it_table FROM gv_str2 TRANSPORTING gv_role WHERE gv_role = '조장님'.
CLEAR gv_str2.

gv_str2-gv_role = '1조 조원'.
MODIFY it_table FROM gv_str2 TRANSPORTING gv_role WHERE gv_role = '학회원'.
CLEAR gv_str2.

cl_demo_output=>display( it_table ).

*--------------------------------------------------------------------*
* 6-2. 인터널 테이블 값 삭제 (DELETE)
* -> 정성균 학회장이 탈주를 하게 되어 학회에 출석하지 못하게 되었습니다 ;;
* 정성균 학회장의 모든 데이터를 테이블에서 삭제하세요..
* cl_demo_output=>display( 변수/스트럭처/인터널테이블명 ) 통해서 확인
*--------------------------------------------------------------------*


DELETE TABLE it_table WITH TABLE KEY gv_member_id = '600000001'.
" DELETE it_table WHERE gv_member_id = '600000001'.

cl_demo_output=>display( it_table ).

*--------------------------------------------------------------------*
* 6-3. 인터널 테이블 값 삽입 (INSERT)
* -> 새로운 회원 '???'이 입회하였습니다. 다른 조원 이름 아무나~
*    신입 학회원 정보를 테이블의 '첫번째 줄'에 추가해주세요~ (INDEX 활용)
* cl_demo_output=>display( 변수/스트럭처/인터널테이블명 ) 통해서 확인
*--------------------------------------------------------------------*


gv_str2-gv_member_id = '60000004'.
gv_str2-gv_name = '손지민'.
gv_str2-gv_role = '학회원'.
INSERT gv_str2 INTO it_table INDEX 1.
CLEAR gv_str2.

gv_str2-gv_member_id = '60000005'.
gv_str2-gv_name = '김민서'.
gv_str2-gv_role = '학회원'.
INSERT gv_str2 INTO it_table INDEX 2.
CLEAR gv_str2.

cl_demo_output=>display( it_table ).


*--------------------------------------------------------------------*
* 7. 도전
* SFLIGHT는 SAP Dictionary의 DB 테이블입니다.
* SAP에서 제공하는 Dictionary에 존재하는 SFLIGHT 테이블(비행 정보 테이블)을 이용해서
* Airline Code, Flight date, Airfare의 정보를 담을 수 있는 스트럭처와 인터널 테이블을 생성하고,
* 임의로 값을 넣고 출력하시오.
* HINT:
* GUI버전: se11에 접속하여 sflight에 대한 정보와 데이터를 조회할 수 있습니다.(/o se11)
* ADT버전: Ctrl+Shift+A로 빠르게 SFLGIHT 검색 or sflight를 ctrl+클릭. ALT키+ <-로 마우스 없이 왔다 갔다 창 이동하면 편리
*         필드, 테이블명에 커서두고 F2를 누르면 필드들의 정보를 확인할 수 있다.
* sflight에 있는 각 필드에 대한 설명이 있으니 각 정보를 뜻하는 적절한 필드를 선택하세요.
*       __ TYPE sflight-??? 를 통해 SFLIGHT에 있는 필드 구조로 스트럭쳐 타입 생성 후 스트럭쳐와 인터널테이블 생성.
*--------------------------------------------------------------------*
TABLES SFLIGHT.

TYPES : BEGIN OF gv_structure,
        gv_airline_code TYPE sflight-carrid,
        gv_flight_date TYPE sflight-fldate,
        gv_airfare TYPE sflight-price,
        END OF gv_structure.

DATA : gt_sflight TYPE TABLE OF gv_structure,
       gt_sflight_str TYPE gv_structure.

gt_sflight_str-gv_airline_code = 'SQ'.
gt_sflight_str-gv_flight_date = '20010519'.
gt_sflight_str-gv_airfare = 2444.
APPEND gt_sflight_str TO gt_sflight.


cl_demo_output=>display( gt_sflight ).


*
*
*
*
*
