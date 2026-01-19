-- ■■■ 데이터베이스에 대한 이해 ■■■ --

-- ○ 데이터(Data)
/*
개인은 물론이고 기업이나 기관은 정보를 필요로한다.
이 정보의 기본(바탕)이 되는 것이 데이터이다.
예를 들면, 회사는 사원, 부서, 급여 등에 대한 데이터(자료)를 관리해야 하고,
물품을 사고파는 회사일 경우 더 많은 데이터(자료)를 관리해야 하며,
이러한 자료를『데이터』라고 한다. 
*/

--==>> 데이터란 현실 세계에서 관찰이나 측정을 통해 수집된 
--     사실(Facts)이나 값(Value), 또는 그 값들의 집합을 말한다.


-- ○ 정보(Informataion)
/*
정보란 데이터를 바탕으로 구체화한 유효한 해석(Interpretation)이나
데이터 상호간의 관계(Relationship)를 의사 결정에 도움이 되도록
가공한 것이다.
*/


-- ○ 데이터베이스(DataBase)
/*
데이터들을 담고 있는 것을 『데이터베이스』라고 한다.
즉, 데이터베이스라 함은 지속적으로 유지·관리해야 할 데이터의 집합인 것이다.
데이터베이스는 조직화된 자료의 집합이며
데이터를 관리하려면 『데이터베이스 관리 시스템』이 필요하다
*/
--==>> 데이터베이스란 여러 응용 시스템들이 공유할 수 있도록 
--     통합, 저장된 운영 데이터의 집합이다.


-- ○ 데이터베이스 관리 시스템(DataBase Management System(Software), DBMS)
--   → 관계형 데이터베이스 관리 시스템(RDBMS)
/*
데이터베이스 관리 시스템은 연관성이 있는 데이터들의 집합을
효율적으로 응요하기 위해 구성된 소프트웨어들의 집합니다.
즉, 데이터와 응용 프로그램의 중간에서 프로그램이 요구하는대로
데이터를 정의하고, 읽고, 쓰고, 갱신하는 등 데이터를 조작하고
이들을 효율적으로 관리하는 프로그램들을 지칭한다.

데이터베이스 관리 시스템은 사용자가 새로운 데이터베이스를 생성하고,
데이터베이스의 구조를 명시할 수 있게 하고,
사용자가 데이터를 효율적으로 질의하고 수정할 수 있도록 한다.
시스템의 고장이나 권한이 없는 사용자로부터
데이터를 안전하게 보호하며, 동시에 여러 사용자가 데이터베이스에
접근하는 것을 제어하는 소프트웨어 패키지인 것이다.

데이터베이스 관리 시스템은 사용자나 어플리케이션 프로그램들이
데이터를 공유할 수 있도록 하는 소프트웨어 패키지이다.
또한, 데이터베이스 내에 자료를 생성, 변경, 조회, 저장할 수 있도록 하는
시스템적인 방법을 제공한다.
일반적으로는 데이터 일치, 접근, 통계, 자동롤백, 복구를 담당한다.
*/

 --==>> 데이터베이스 관리 시스템(DBMS)이란
/*	모든 응용 프로그램들이 데이터베이스를 공유할 수 있도록
	관리해주고 데이터베이스를 유지하기 위한 일련의
	소프트웨어 시스템이다.
*/

---------------------------------------------------------------------------------------------

-- ■■■ 오라클 설치 ■■■ --

-- https://www.oracle.com/

-- Oracle 26ai → 최신 버전
-- Oracle 11g  → 설치한 버전

--  _ 	   _
-- eXpress Edition
--    → 법적으로 완전 무료 버전이다.
--	  기업체나 교육기관 등에서 무료로 사용이 가능한 버전이며,
--	  프로그램 개발용으로는 충분하지만,
--	  데이터베이스 서버용으로는 다소 부족한 기능을 가진 버전이라 할 수 있다.

-- _ 	    _	     _	      _	      _    _	_    _	    _	       _
-- Standard Edition, Standard Edition One, Data Ware House, Enterprise Edition 	
--    → 다운로드는 가능하지만, 기업체나 교육기관 등에서 사용하게 되면
--	  사용 중 검열 시 정식 라이센서를 제시할 수 있어야 한다.
--	  프로그램 개발용 뿐 아니라, 데이터베이스 서버용으로도
--	  충분한 기능을 가지고 있는 버전들이다.

-- ○ 기본적으로 설치 과정은 까다롭지 않다.
--	(11g eXpress Edition 기준)

--	- 기본 설치 경로: 『C:\oraclexe\』
--	- SYS 계정 패스워드 설정: 『java004$』
--	- Port Number: 기본 리스너 → 1521 / HTTP 리스너 → 8080

/*
  ※ 참고. 오라클 데이터베이스의 파일 위치
           오라클 관련 프로그램이 설치되는 경로와
	   관리되고 유지되는 데이터 파일의 위치는
	   물리적으로 다른 경로를 선택하는 것을 권장한다.
	   즉, 오라클 관련 프로그램이 C드라이브에 설치된다고 가정할 때
	   데이터베이스 파일의 위치는 D드라이브로 설정하는 것이 바람직하다는 것이다.
	   (안정성과 성능 향상 - 파티션 개념의 논리적으로 다른 경로는 해당없음)
*/


-- ■■■ 오라클 제거 ■■■ --
/*
1. (Windows 11 기준) 
시작 > 설정(윈도우키 + i) > 앱 > 설치된 앱 	→ Oracle 관련 항목 제거

2.
실행 창 호출(윈도우키 + r) > 『services.msc』입력 → 서비스 창 호출 
(나중에 집에서 설치할 때 여기서 OracleServiceXE 속성에서 수동으로 바꿔서 쓸 때마다 서비스 시작을 누르고 끝나고 중지를 누르기)

3.
서비스 리스트의 항목을 통해 확인해 보면
『Oracle』로 시작하는 서비스가 여럿 확인된다.
즉, Oracle Server는 서비스를 기반으로 동작한다는 것이다.
위에서 언급한대로 오라클 프로그램을 제거했다 하더라도
운영체제(OS)상에서 오라클은 서비스로 동작하기 때문에
이 오라클 관련한 서비스를 레지스트리에서 제거해 주어야 한다.

※ 레지스트리에서 오라클 서비스를 제거하는 방법

    ① 『윈도우 + r』 입력(실행창 호출) → 『regedit』 입력 → 레지스트리 편집기 호출

    ② 『HKEY_LOCAL_MACHINE』 > 『SOFTWARE』 > 『Oracle』 항목 삭제

    ③ 『HKEY_LOCAL_MACHINE』 > 『SYSTEM』 > 『CurrentControlSet』 > 『Services』
	→ 『Oracle』로 시작하는 모든 항목 삭제

    ④ 『HKEY_LOCAL_MACHINE』 > 『SYSTEM』 > 『ControlSet001』 > 『Services』
	→ 『Oracle』로 시작하는 모든 항목 삭제 

    ⑤ 『HKEY_LOCAL_MACHINE』 > 『SYSTEM』 > 『ControlSet002』 (존재한다면...) > 『Services』
	→ 『Oracle』로 시작하는 모든 항목 삭제 

    ⑥ 『HKEY_LOCAL_MACHINE』 > 『SYSTEM』 > 『ControlSet003』(존재한다면...) > 『Services』
	→ 『Oracle』로 시작하는 모든 항목 삭제
 
    ※  변경된 레지스트리 정보가 적용되기 위해서는
	반.드.시. 재부팅을 해 주어야 한다.
    

4.
재부팅 이후 탐색기 상에서 오라클 홈과 관련된 모든 내용을 찾아서 물리적으로 삭제한다.

5.
또한 데이터 파일 경로 및 설치 경로의 모든 디렉터리와 파일들을
물리적으로 삭제할 수 있도록 한다.
*/
--==>> 여기까지 모든 과정을 수행해야 Oracle Server는 깨끗하게 제거된다. 

-------------------------------------------------------------------------------------------

-- ■■■ 오라클 접속 및 구동 ■■■ --

-- 실행창 호출(윈도우키 + r) > 『cmd』입력 → 콘솔창(명령 프롬프트) 호출

--(명령 프롬프트 상태에서)
-- ○ 접속된 사용자 없이 단순히 SQL 프롬프트만 띄우도록 한 것
--C:\>sqlplus/nolog
--==>>
/*
SQL*Plus: Release 11.2.0.2.0 Production on 월 12월 29 16:42:23 2025
Copyright (c) 1982, 2014, Oracle.  All rights reserved.
SQL>
*/

-- ※ 『sqlplus』는 SQL을 수행하기 위해 ORCALE에서 제공하는 도구(툴, 유틸리티)이다.

-- ※ 『C:\oraclece\app\oracle\product\11.2.0\server\bin』
/*	에 존재하는 『sqlplus.exe』
	오라클을 설치하는 과정에서 이미 이 경로가 환경변수 『path』에
	등록되었기 때문에 해당 경로까지 찾아들어가지 않더라도
	『C:\>sqlplus』와 같은 형식으로 명령어 사용이 가능한 상태인 것이다.
*/
-- ※  이제는 일반적인 도스 명령어(윈도우 명렁어)를 수행할 수 없다.
--	(사전에 약속된 명령 이외에는 수행할 수 있는 상태가 아니다.)

-- ○ 현재 접속한 사용자 계정을 조회하는 구문
--SQL> show user
--==>> USER is ""

--SQL> exit

--C:\>

--C:\>sqlplus sys/java004$ as sysdba
--==>>
/*
SQL*Plus: Release 11.2.0.2.0 Production on 월 12월 29 17:05:46 2025
Copyright (c) 1982, 2014, Oracle.  All rights reserved.
Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
SQL>
*/

-- ○ 현재 접속한 사용자 계정을 조회
--SQL> show user
--==>> USER is "SYS"

-- ※ 현재 우리는 sys 계정을 통해
--    오라클 최고 관리자 권한을 가진 상태에서
--    오라클 서버에 접속한 상태이다.

-- ○ 오라클 서버 인스턴스 상태 조회(사용가능상태 여부 확인)
--      전원의 on/off 여부 등 일반적으로 접속의 가능 여부를 
--      확일할 때 사용하는 명령
--SQL> select status from v$instance;
--==>>
/*
STATUS
------------------------
OPEN
*/
--> 오라클 서버가 정상적으로 구동중(startup)인 상태임을 의미

-- ○ 두 번째로 일반 사용자 계정인 『hr』로 연결을 시도
--SQL> connect hr/lion
--==>> 
/*
ERROR:
ORA-28000: the account is locked

Warning: You are no longer connected to ORACLE.
SQL>
*/
--> 일반 사용자 계정인 『hr』은 존재하지만 잠겨있는 상태이므로
--    오라클 서버 접속이 불가능한 상태

-- ○ hr계정의 잠금을 해제하기 위해 sys로 연결
--SQL> connect sys/java004$ as sysdba
--==>>Connected.

--SQL> show user
--==>> USER is "SYS"


-- ○ 오라클 사용자 계정들의 상태 조회(확인) → sys인 상태에서
--SQL> set linesize 500
--SQL> select username, account_status from dba_users;
--==>>
/*
USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
SYS                                                          OPEN
SYSTEM                                                       OPEN
ANONYMOUS                                                    OPEN
APEX_PUBLIC_USER                                             LOCKED
FLOWS_FILES                                                  LOCKED
APEX_040000                                                  LOCKED
OUTLN                                                        EXPIRED & LOCKED
DIP                                                          EXPIRED & LOCKED
ORACLE_OCM                                                   EXPIRED & LOCKED
XS$NULL                                                      EXPIRED & LOCKED
MDSYS                                                        EXPIRED & LOCKED

USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
CTXSYS                                                       EXPIRED & LOCKED
DBSNMP                                                       EXPIRED & LOCKED
XDB                                                          EXPIRED & LOCKED
APPQOSSYS                                                    EXPIRED & LOCKED
HR                                                           EXPIRED & LOCKED
16 rows selected.
SQL>
*/

--> 현재 hr 일반 사용자 계정은 EXPIRED & LOCKED인 상태


-- ○ hr 사용자 계정 잠금 해제 → 현재 sys로 연결된 상태
--SQL> alter user hr account unlock;
--==>> User altered.


-- ○ 다시 오라클 사용자 계정들의 상태 조회(확인)
--SQL> select username, account_status from dba_users;
--==>>
/*

USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
SYS                                                          OPEN
SYSTEM                                                       OPEN
ANONYMOUS                                                    OPEN
HR                                                           EXPIRED
APEX_PUBLIC_USER                                             LOCKED
FLOWS_FILES                                                  LOCKED
APEX_040000                                                  LOCKED
OUTLN                                                        EXPIRED & LOCKED
DIP                                                          EXPIRED & LOCKED
ORACLE_OCM                                                   EXPIRED & LOCKED
XS$NULL                                                      EXPIRED & LOCKED

USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
MDSYS                                                        EXPIRED & LOCKED
CTXSYS                                                       EXPIRED & LOCKED
DBSNMP                                                       EXPIRED & LOCKED
XDB                                                          EXPIRED & LOCKED
APPQOSSYS                                                    EXPIRED & LOCKED
16 rows selected.
SQL>
*/

--> 다시 조회한 결과 hr 계정의 상태는 EXPIRED이며,  
--    잠금은 해제한 상황이지만 패스워드에 대한 유효기간이 만료된 상황이므로
--    이를 재설정해야 한다.


-- ○ 계정 정보 변경(패스워드 설정 변경) → sys로 접속된 상태
--SQL> alter user hr identified by lion;
--==>> User altered.


-- ○ 다시 오라클 사용자 계정들의 상태 조회(확인
--SQL> select username, account_status from dba_users;
--==>>
/*
USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
SYS                                                          OPEN
SYSTEM                                                       OPEN
ANONYMOUS                                                    OPEN
HR                                                           OPEN
APEX_PUBLIC_USER                                             LOCKED
FLOWS_FILES                                                  LOCKED
APEX_040000                                                  LOCKED
OUTLN                                                        EXPIRED & LOCKED
DIP                                                          EXPIRED & LOCKED
ORACLE_OCM                                                   EXPIRED & LOCKED
XS$NULL                                                      EXPIRED & LOCKED

USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
MDSYS                                                        EXPIRED & LOCKED
CTXSYS                                                       EXPIRED & LOCKED
DBSNMP                                                       EXPIRED & LOCKED
XDB                                                          EXPIRED & LOCKED
APPQOSSYS                                                    EXPIRED & LOCKED
16 rows selected.
SQL>
*/

--> hr 사용자 계정의 상태가 『OPEN』임을 확인

-- ○ 계정 잠금 해제 및 유효기간 만료 상태의 해제 이후
--      다시 hr 계정으로 오라클 접속 시도
--SQL> conn hr/lion
--==>> Connected.

--SQL> show user
--==>> USER is "HR"

-- ○ 현재 오라클 서버의 사용자 계정 상태에 대한 정보 조회
--SQL> select username, account_status from dba_user;
--==>>
/*
select username, account_status from dba_user
                                     *
ERROR at line 1:
ORA-00942: table or view does not exist

SQL>
*/
--> 『hr』 이라는 일반 사용자 계정을 통해서는
--  『dba_users』의 조회가 불가능한 상황임을 확인


-- ○ host 명령어

--SQL> dir
--SP2-0042: unknown command "dir" - rest of line ignored.
--SQL> ipconfig
--SP2-0042: unknown command "ipconfig" - rest of line ignored.

-- 도스 명령 체계로 전환하거나
--   라인 단위에서 도스명령어 입력이 가능하다
--   예를 들면 host dir, host cls, host ipconfig 등
--   유닉스 계열에서는 『host』 명령어 뿐만 아니라 !도 사용이 가능하다
--   하지만, 윈도우 계열에서는 『host』 명령어만 사용이 가능하다.
--   host 상태에서 빠져나갈 때는『exit』 명령을 입력한다.


-- ※   Administrator(윈도우 관리자 계정)가 ORA_DBA(오라클 관리자 계정)의 그룹에 포함되어있을 경우 
--	취약한 보안 정책으로 인해 실무에서는 정말 특별한 경우가 아니고서는
--	반드시 제외시키고 사용해야 한다.
--==>> ORA_DBA 그룹에서 윈도우 관리자 계정 제거!


-- ※ 제거 방법
-- 운영체제 에디션 버전 : ver.Pro
--   시작버튼 마우스 우클릭 > 컴퓨터 관리 > 로컬 사용자 및 그룹 진입 > 그룹 > ORA_DBA > 구성원에서 윈도우 계정 제거

-- 운영체제 에디션 버전 : ver.Pro 이외의 버전
--   실행창 호출(윈도우키 + r) → 『lusrmgr.msc』 입력 또는 『control userpasswords2』입력
--   을 통해 로컬 사용자 및 그룹 관리 진입 > 그룹 > ORA_DBA > 구성원에서 윈도우 계정 제거


-- ※ 제거 이후 sys의 계정 및 패스워드가 일치하지 않으면
--      오라클 서버에 접속할 수 없는 상태가 된다.

-- ○ hr 사용자 계정에 sysdba 권한 부여하기 → sys가

--SQL> conn sys/java004$ as sysdba
--==>> Connected.
--SQL> show user
--==>> USER is "SYS"

--SQL> grant sysdba to hr;
--==>> Grant succeeded.

-- ○ 확인 → hr 계정으로 접속 → 『as sysdba』로 연결
--SQL> conn hr/lion as sysdba
--==>> Connected.
--SQL> show user
--==>> USER is "SYS"

-- ○ sysdba 권한을 부여받기 전까지는 불가능 했떤
--      현재 오라클 서버 사용자 계정의 상태 조회
--      (sysdba 권한을 부여받은 hr계정인 상태로)
--SQL> set linesize 500
--SQL> select username, account_status from dba_users;
--==>>
/*
USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
SYS                                                          OPEN
SYSTEM                                                       OPEN
ANONYMOUS                                                    OPEN
HR                                                           OPEN
APEX_PUBLIC_USER                                             LOCKED
FLOWS_FILES                                                  LOCKED
APEX_040000                                                  LOCKED
OUTLN                                                        EXPIRED & LOCKED
DIP                                                          EXPIRED & LOCKED
ORACLE_OCM                                                   EXPIRED & LOCKED
XS$NULL                                                      EXPIRED & LOCKED

USERNAME                                                     ACCOUNT_STATUS
------------------------------------------------------------ ----------------------------------------------------------------
MDSYS                                                        EXPIRED & LOCKED
CTXSYS                                                       EXPIRED & LOCKED
DBSNMP                                                       EXPIRED & LOCKED
XDB                                                          EXPIRED & LOCKED
APPQOSSYS                                                    EXPIRED & LOCKED

16 rows selected.

SQL>
*/

-- ○ hr 사용자 계정에 부여한 sysdba 권한 박탈 → sys가
--SQL> conn sys/java004$ as sysdba
--==>> Connected.
--SQL> show user
--==>> USER is "SYS"
--SQL> revoke sysdba from hr;
--==>> Revoke succeeded.


-- ○ 권한 박탈 후 hr 계정을 통해 sysdba 권한으로 오라클 접근 시도
--SQL> conn hr/lion as sysdba
--==>>
/*
ERROR:
ORA-01031: insufficient privileges

Warning: Your are no longer connected to ORACLE/
*/

-- ○ 접속
--SQL> connect
--SQL> conn

-- ○ 접속 종료
--SQL> disconnect
--SQL> disconn

-- ○ 일반 사용자 계정 hr로 다시 연결
--SQL> conn hr/lion
--==>> Connected.
--SQL> show user
--==>> USER is "HR"


-- ※ 오라클 서버 구동/중지
--startup / shutdown [immediate]


-- ○ 일반 사용자 계정 hr로 오라클 서버 중지 명령 시도
--SQL> shutdown
--==>> ORA-01031: insufficient privileges
-- 즉, 일반 사용자 계정으로는 오라클 서버의 구동을 중지시킬 수 없다.

--SQL> shutdown immediate
--==>>ORA-01031: insufficient privileges
-- 즉, 일반 사용자 계정으로는 오라클 서버의 구동을 중지시킬 수 없다.

-- ○ sys로 접속하여 오라클 서버 중지 명령 시도
--SQL> conn sys/java004$ as sysdba
--==>> Connected.

--SQL> show user
--==>> USER is "SYS"

--SQL> shutdown
--==>>
/*
Database closed.
Database dismounted.
ORACLE instance shut down.
*/


-- ○ 오라클 서버의 구동이 중지된 상태에서 
--      일반 사용자 hr로 오라클 접속 시도
--SQL> conn hr/lion
--==>>
/*
ERROR:
ORA-01034: ORACLE not available
ORA-27101: shared memory realm does not exist
Process ID: 0
Session ID: 0 Serial number: 0

Warning: You are no longer connected to ORACLE.
*/

-- ○ 오라클 서버의 재가동을 위해 sys로 연결
--SQL> conn sys/java004$ as sysdba
--==>> Connected to an idle instance.(→ 휴지 인스턴스에 접속되었음)

--SQL> startup
--==>>
/*
ORACLE instance started.

Total System Global Area 1068937216 bytes
Fixed Size                  2260048 bytes
Variable Size             616563632 bytes
Database Buffers          444596224 bytes
Redo Buffers                5517312 bytes
Database mounted.
Database opened.
SQL>
*/

-- ※ 오라클 서버를 구동하는 명령
--SQL> startup

-- ※ 오라클 서버를 중지하는 명령
--SQL> shutdown [immediate]


-- ※ 오라클 서버를 구동 및 중지하는 명령은
--      『as sysdba』 또는 『as sysoper』로 연결했을 때만 가능하다.


-- ○ hr 사용자 계정에 『sysoper』 권한 부여하기 → sys가
--SQL> conn sys/java004$ as sysdba
--==>> Connected.

--SQL> show user
--==>> USER is "SYS"

--SQL> grant sysoper to hr;
--==>> Grant succeeded.

-- ○ 확인 → hr 계정 접속 → sysoper 권한으로
--SQL> conn hr/lion as sysoper
--==>> Connected.

--SQL> show user
--==>> USER is "PUBLIC"
--> 『PUBLIC』 즉, 운영자의 권한으로 접속된 상황임을 확인

-- ○ sysoper의 권한을 가진 hr 계정으로 오라클 서버 중지 명령 시도
--SQL> shutdown
--==>>
/*
Database closed.
Database dismounted.
ORACLE instance shut down.
*/

-- ○ sysoper의 권한을 가진 hr 계정으로 오라클 서버 구동 명령 시도
--SQL> startup
--==>>
/*
ORACLE instance started.
Database mounted.
Database opened.
*/

-- ○ sysoper의 권한을 가진 hr 계정으로 오라클 서버의 사용자 계정 상태 조회
--SQL> select username, account_status from dba_users;
--==>>
/*
select username, account_status from dba_users
                                     *
ERROR at line 1:
ORA-00942: table or view does not exist
*/

-- ■■■ 오라클 서버 연결 모드 3가지 방법 ■■■ --

-- 1. as sysdba
/*   → as sysdba로 연결하면 오라클 서버의 관리자로 연결되는 것이다. 
   user명은 sys로 확인된다.
   오라클 서버 관리자로 연결되는 것이기 때문에
   오라클 서버에서 제공하는 모든 기능을 전부 활용할 수 있다.
   오라클 서버가 startup 또는 shutdown 되어도 연결이 가능하다.
   → 기본적인 연결은 『conn 계정/패스워드 as sysdba』 형태로 연결하게 된다.
   → 일반적인 연결은 『conn 계정 as sysdba』 형태로 연결하게 된다.

-- 2. as sysoper
   → as sysoper로 연결하면 오라클 서버의 운영자로 연결되는 것이다.
   user명을 PUBLIC으로 확인된다.
   사용자 계정 정보 테이블에 접근하는 것은 불가능하다.
   오라클 서버의 구동 및 중지 명령 수행이 가능하다.
   오라클 서버가 startup 또는 shutdown되어도 연결이 가능하다.
   → 기본적인 연결은 『conn 계정/패스워드 as sysoper』 형태로 연결하게 된다.
   → 일반적인 연결은 『conn 계정 as sysoper』 형태로 연결하게 된다.

-- 3. normal
   → 오라클 서버에 존재하는 일반 사용자로 연결되는 것이다.
   오라클 서버가 구동중인 상태에서만 연결이 가능하고
   오라클 서버가 구동 중지 상태일 경우 연결이 불가능하다.
   관리자가 부여해준 권한(또는 롤)을 통해서만 사용이 가능하다
   → 기본적인 연결은 『conn 계정/패스워드』 형태로 연결하게 된다.
   → 일반적인 연결은 『conn 계정』 형태로 연결하게 된다.
*/


















































