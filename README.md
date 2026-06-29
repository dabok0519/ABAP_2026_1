# SAP ERP Study — 2026 1학기 학회 활동 기록

> Classic ABAP 기초부터 SAP BTP · Cloud ABAP · RAP · Fiori 개발까지,
> **"데이터 모델(CDS)을 중심에 두고 백엔드에서 UI까지 체계적으로 만드는"** 현대 SAP 개발 흐름을 직접 실습하며 정리한 기록입니다.

SAP 컨설팅을 목표로 ERP 연구회에서 한 학기 동안 수행한 과제들을 단계별로 정리했습니다. 단순 따라하기가 아니라, 각 구성요소가 **왜 그렇게 나뉘는지 / 어떤 역할을 하는지**를 이해하는 데 초점을 맞췄습니다.

---

## 한눈에 보는 학습 흐름

```
Classic ABAP 기초          현대 SAP 개발 (Cloud ABAP)
─────────────              ─────────────────────────
변수 · 내부테이블           BTP Trial 환경 구축
Open SQL                   ADT 연결 (ABAP Cloud Project)
                  ───►     RAP 구조 (CDS / Behavior / Service)
                           Fiori 개발 (Fiori Elements · BAS)
```

핵심 패러다임 전환: **Data to Code → Code to Data (Code Push Down)**, **개발자 중심 → 비즈니스 의미 중심**

---

## 주차별 정리

### Week 01–02 · Classic ABAP 기초
ABAP의 기본 데이터 처리 메커니즘을 학습했습니다.

- **변수 / 데이터 타입** — ABAP 기본 자료형과 선언
- **내부 테이블 (Internal Table)** — `APPEND` / `MODIFY` / `INSERT` / `DELETE`, Work Area를 통한 행 단위 처리, `LOOP` / `READ`
- **Open SQL** — DB Table에 대한 `INSERT` / `UPDATE` / `MODIFY` / `DELETE`, 애플리케이션 서버에서 DB 데이터를 가져오는 전통적 방식

> 💡 이 단계는 이후 Cloud ABAP에서 **CDS View 기반 Code Push Down** 철학과 비교하는 출발점이 됩니다. (기존: 데이터를 코드로 끌어와 계산 → 현대: 연산을 DB Layer로 내림)

### Week 03 · Classic ABAP vs Cloud ABAP / Fiori 개발 방식
두 패러다임의 차이와 Fiori 개발 4가지 방식을 정리했습니다.

| 구분 | Classic ABAP | Cloud ABAP |
|------|--------------|------------|
| 개발 환경 | SAP GUI | ADT · BAS · BTP |
| 화면 구성 | Dynpro · ALV 직접 개발 | Fiori Elements · UI Annotation |
| 데이터 모델 | Table 중심 | **CDS View 중심** |
| 서비스 제공 | Function Module · RFC | OData Service |
| 핵심 방향 | 개발자 중심 | 비즈니스 의미 중심 |

**Fiori 개발 4가지 방식**: ① 백엔드 Annotation 기반 (Fiori Elements) ② Fiori Tools 기반 ③ Guided Development ④ Freestyle (SAPUI5)

### Week 04 · BTP Trial 세팅 및 ADT 연결
SAP BTP(Platform as a Service) 환경을 구축하고 Eclipse(ADT)에 연결했습니다.

- **BTP Trial 계정 생성** — 싱가포르 리전(Azure 클라우드) Subaccount 구성
- **서비스 구독** — `ABAP Environment`(Clean Core 전략 기반 클라우드 ABAP 실행 환경), `SAP Business Application Studio`(브라우저 기반 IDE)
- **ADT 연결** — New → ABAP Cloud Project, FLP URL 기반 로그온
- **데모 패키지 생성** — `ZDMO_CL_FE_TRAVEL_GENERATOR`로 교육용 Travel RAP 구조 및 데이터 자동 생성, Favorite Package 등록

> 📌 IaaS / PaaS / SaaS 개념과 BTP의 위치(PaaS)도 함께 정리.

### Week 05 · RAP 구조 이해 (Backend) + Fiori Elements
자동 생성된 RAP 구조를 직접 분석하며 각 구성요소의 역할을 정리했습니다.

**RAP 8계층 흐름** (Data → Business Logic → Service → UI):
```
DB Table → Interface View → Projection View → Metadata Extension
        → Behavior Definition → Service Definition → Service Binding → Fiori Elements
```

**CDS 4가지 종류(네이밍)**:

| 종류 | Prefix | 역할 |
|------|--------|------|
| Basic | `ZI_` | 1:1 테이블 추상화 |
| Composite | `ZI_` | JOIN / Aggregation |
| Consumption | `ZC_` | Fiori / OData 노출 |
| Extension | `ZE_` | 표준 CDS 확장 |

실습: Metadata Extension을 생성해 백엔드에서 List Report / Object Page UI를 구성 (`@UI.lineItem`, `@UI.selectionField` 등)

### Week 06 · RAP 복습 + BAS 실습
RAP 계층 분리의 **이유**를 깊이 있게 복습하고, Fiori Tools(BAS)로 같은 결과를 만들어 비교했습니다.

**CDS View를 3계층으로 나누는 이유** — 역할 분리 · 재사용성 · 외부 공개 범위 통제 · UI와 데이터 모델 변경의 분리

| RAP 요소 | 식당 비유 |
|----------|-----------|
| DB Table | 식재료 창고 |
| Interface View | 주방 내부용 전체 레시피 |
| Projection View | 손님에게 보여줄 메뉴판 |
| Metadata Extension | 메뉴판 디자인·배치 |
| Behavior Definition | 주문/취소/수정 가능 여부 |
| Behavior Implementation | 실제 조리 방법 |
| Projection Behavior | 손님에게 허용된 주문 방식 |

**BAS 실습**: SAP Fiori Generator로 List Report Page 생성 → Page Map(No-Code) 으로 Flexible Column Layout · Initial Load 설정 → 백엔드 Annotation 방식과 비교

> 💡 핵심 인사이트: 백엔드 메타데이터 방식과 Fiori Tools 방식은 **같은 결과를 다른 경로로** 만든다. No-Code는 빠르고 쉽지만 표준 범위를 벗어나면 Freestyle 개발이 필요하다.

---

## 폴더 구조 (abapGit)

이 레포는 **abapGit** 형식으로 관리됩니다. 각 ABAP 오브젝트는 `.abap`(소스) + `.xml`(메타데이터) 쌍으로 저장됩니다.

```
ABAP_2026_1/
├── README.md
└── src/
    ├── package.devc.xml                  # 패키지 정의 (루트)
    ├── z180_message.msag.xml             # 메시지 클래스 Z180_MESSAGE
    ├── week01-02-abap-basics/            # Week 1–2: 변수 · 내부테이블 · Open SQL
    ├── week03-dynpro-alv/                # Week 3: Dynpro + ALV 기초
    └── week05-alv-advanced/              # Week 5: ALV 심화 · Function Group
```

---

### `src/week01-02-abap-basics/` — ABAP 기초

| 파일 | 설명 |
|------|------|
| `z_180_firstweek.prog.abap` | Week 1: 변수, 구조체, 내부테이블 (APPEND/MODIFY/DELETE/INSERT), SFLIGHT 조회 |
| `z_180_secondweek.prog.abap` | Week 2: Open SQL — SELECT, JOIN, GROUP BY, HAVING (SFLIGHT/SPFLI/SCARR) |
| `z_180_secondweek_2.prog.abap` | Week 2-2: MARA 테이블 조회, Selection Screen, INCLUDE 구조 (TOP + F01) |
| `z_180_top.prog.abap` | Include — MARA 조회용 SELECTION-SCREEN 선언 |
| `z_180_f01.prog.abap` | Include — FORM SELECT_MARA, DISPLAY 루틴 |
| `z_180_car.prog.abap` | 실습: 구조체, 파라미터, CASE 문 |
| `z_180_debugging.prog.abap` | 실습: BAPI_USER_GET_DETAIL 호출 |
| `z_subroutine_practice.prog.abap` | 실습: PERFORM, CALL FUNCTION, TRY/CATCH |

---

### `src/week03-dynpro-alv/` — Dynpro + ALV 기초

| 파일 | 설명 |
|------|------|
| `z_thirdweek_1.prog.abap` | 메인 프로그램: Dynpro 화면 0100 + CUA Status S100, ALV Grid (SFLIGHT), INCLUDE 구조 |
| `z_thirdweek_1_user_top.prog.abap` | Include TOP — 전역 데이터: SFLIGHT 테이블, Docking Container, ALV Grid 오브젝트 |
| `z_thirdweek_1_o01.prog.abap` | Include PBO — Docking Container + ALV Grid 생성, 필드카탈로그 수동 구성, set_table_for_first_display |
| `z_thirdweek_1_i01.prog.abap` | Include PAI — user_command_i01 위임 |
| `z_thirdweek_1_status_0100o01.prog.abap` | Include — SET PF-STATUS 'S100', SET TITLEBAR |
| `z_thirdweek_1_user_command_i01.prog.abap` | Include — CASE ok_code: BACK/EXIT/CANC 처리 |
| `z_thirdweek_1_user_f01.prog.abap` | Include — FORM GET_DATA: SELECT * FROM SFLIGHT |
| `z_week3_top.prog.abap` | Include TOP (대안): SELECT-OPTIONS S_CARRID |
| `z_week3_f01.prog.abap` | Include F01 (스텁) |
| `z_week3_i01.prog.abap` | Include PAI (스텁) |
| `z_week3_o01.prog.abap` | Include PBO (스텁) |
| `z_zm_180_debug_test.prog.abap` | 실습: BREAK-POINT, DO 루프, 0으로 나누기 TRY/CATCH |
| `z_zm_180_pratice.prog.abap` | 실습: SCARR WRITE + HIDE + AT LINE-SELECTION, MESSAGE-ID Z180_MESSAGE |

---

### `src/week05-alv-advanced/` — ALV 심화 · Function Group

| 파일 | 설명 |
|------|------|
| `z_180_alv.prog.abap` | 메인 프로그램: MAKT 조회, CALL SCREEN 100, INCLUDE 구조 (TOP/I01/F01/O01) |
| `zy_week5_f01.prog.abap` | Include F01 — FORM get_data / set_alv / create_object / set_fieldcatalog(LVC_FIELDCATALOG_MERGE) / set_layout / display_alv, FIELD-SYMBOL 활용 |
| `zy_week5_i01.prog.abap` | Include PAI — MODULE exit: BACK/EXIT/CANC |
| `z_180_alv_opt.prog.abap` | ALV 옵션 실습: 신호등(STATUS), 행 색상(LINE_COLOR char4), 셀 색상(CELL_COLOR lvc_t_scol), REUSE_ALV_GRID_DISPLAY |
| `z_180_alv_test.prog.abap` | ALV 테스트: INCLUDE z_mara_alv_top/f01, CALL SCREEN 100 |
| `z_180_alv_test_user_commandi01.prog.abap` | Include — MODULE user_command_0100: FREE go_grid/go_dock, LEAVE TO TRANSACTION |
| `z_180_alv_split_status_0100o01.prog.abap` | Include — STATUS_0100 모듈 (주석 처리) |
| `z_180_alv_user_command_0100i01.prog.abap` | Include — USER_COMMAND 스텁 |
| `z_180_function_group_test.fugr.xml` | Function Group: Z_180_FM_PRATICE — IM_P1/IM_P2 TYPE I → EX_P1, 예외: DIVIDE_BY_ZERO/CALCULATION_ERROR |

---

## 핵심 키워드

`SAP BTP` · `Cloud ABAP` · `RAP (RESTful ABAP Programming)` · `CDS View` · `OData V4` · `Fiori Elements` · `SAP Business Application Studio` · `Clean Core` · `Code Push Down`

---

## 배운 점 / 회고

- **CDS View 설계가 가장 중요하다** — RAP의 모든 계층이 CDS를 중심으로 확장되므로, 데이터 모델링 역량이 핵심임을 체감했습니다.
- **"왜 나누는가"를 이해하는 것** — 단순히 구조를 외우는 것이 아니라, 역할 분리·재사용성·유지보수 관점에서 각 계층의 존재 이유를 설명할 수 있게 되었습니다.
- **AI 활용의 전제는 기본기** — ADT MCP 등으로 바이브 코딩이 가능해졌지만, 코드를 해석할 수 있는 능력이 없으면 독이 된다는 점을 학습 방향의 기준으로 삼았습니다.

---

*본 레포는 SAP ERP 연구회 2026년 1학기 활동의 개인 학습 기록입니다.*
