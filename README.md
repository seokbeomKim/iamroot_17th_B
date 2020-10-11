# 최신 ARM64 리눅스 커널 분석

## 커뮤니티: IAMROOT 17차 7조

* [jake.dothome.co.kr][#moonc] | 문c 블로그
* [www.iamroot.org][#iamroot] | IAMROOT 홈페이지

[#iamroot]: http://www.iamroot.org
[#moonc]: http://jake.dothome.co.kr

## History

* 첫 모임: 2020년 8월 22일

### 1주차

* 2020.08.22, 온라인 세션 (with Zoom)
* [오리엔테이션](./20200822/orientation.md)

### 2주차

* 2020.08.23, 온라인 세션 (with Zoom)
* ~p153, 태스크 관리 및 메모리 관리
* 스터디 방식 논의

  * 차주 3장, 4장 내용으로 토의 또는 궁금한 내용 정리해올 것

  * 앞으로 매 장절 끝날 때마다 논의하고 넘어가는 것으로 방식 논의

### 3주차

* 2020.09.05, 온라인 세션 (with Zoom)
* 3장 예제 파일 실습

  * [예제 파일 참고](./20200905/chapter_3)

* TO-DO

  * QEMU & Ftrace 이용한 시스템콜 예제 확인

  * 코드로 알아보는 ARM 리눅스 커널 - 1장

### 4주차

* 2020.09.12, 온라인 세션 (with Zoom)

* System Call 구현 실습 ([예제 파일 참고](./20200912/))

  * [환경 구성 가이드(Arm64 커널 & QEMU)](https://www.notion.so/chaoxifer/buildroot-qemu-c115e67902c7490f93c011efa0653b54)

* <<코드로 알아보는 ARM 리눅스 커널>>

  * (~p26) 1.4.4 캐시 일관성의 두 가지 관점

### 5주차

* 2020.09.19, 온라인 세션 (with Zoom)

* <<코드로 알아보는 ARM 리눅스 커널>>

  * (~p52) 1.7.4 버스 프로토콜과 캐시 일관성 인터커넥트

### 6주차

* 2020.09.26, 온라인 세션 (with Zoom)

* Kernel 소스 분석: head.S

  * 커널 및 U-Boot 부트로더 이용한 소스 코드 분석
  * 2.1 ~ 2.1.3 (CPU 부트 모드 저장)
  * Kernel (v5.8.11)
  * U-Boot (master: 1da91d9bcd6e5ef046c1df0d373d0df87b1e8a72)

* 분석 소스코드: https://github.com/seokbeomKim/iamroot_17th_group7/tree/20200926
* 추석 연휴인 관계로 다음 스터디는 10/10일에 진행됩니다.

* 부트로더(u-boot)에서 EFI pe entry 부분을 설정하고 리눅스 커널에서
  읽어오는 부분에 대해, 윤여름님께서 아래와 같이
  설명해주셨습니다. 관련 내용은 [EFI boot from u-boot to kernel
  start-point](https://github.com/seokbeomKim/iamroot_17th_group7/blob/kernel/Documentation/iamroot/set_efi_pe_before_kernel_start.org)

### 8주차

* 2020.10.10, 온라인 세션 (with Zoom)

* <<코드로 알아보는 ARM 리눅스 커널>>

  * 2.1.4 페이지 테이블 생성

* head.S 에서 사용하는 기본 ARM 어셈블리 언어 재확인

* 차주에 아래 내용으로 진행하겠습니다.

  * 커널 분석 환경 구성
  * head.S 내에서 사용하는 매크로 분석
  * 2.1.4 페이지 테이블 생성
