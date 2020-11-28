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

  * 주요 ARM64 어셈블리 명령어: https://courses.cs.washington.edu/courses/cse469/18wi/Materials/arm64.pdf

* 차주에 아래 내용으로 진행하겠습니다.

  * 커널 분석 환경 구성
  * head.S 내에서 사용하는 매크로 분석
  * 2.1.4 페이지 테이블 생성

### 9주차

* 2020.10.17, 온라인 세션 (with Zoom)

* head.S 에서 사용하는 기본 ARM 어셈블리 및 매크로 분석

  * preserve_boot_args (head.S)
  * __inval_dcache_area (cache.S)
  * read_ctr 매크로
    * alternative_if_not 관련 내용으로 분석
	  - http://jake.dothome.co.kr/alternative/
	* CPU capability
	  - http://jake.dothome.co.kr/cpucaps64/

### 10주차

* 2020.10.21, 온라인 세션 (with Zoom)

### 11주차

* 2020.10.31, 온라인 세션 (with Zoom)
* __create_page_tables 분석
  * init_pg_dir, idmap_pg_dir 초기화
* 다음주 토의 내용
  * idmap 에서 VA_BITS < 48 일 때 additional translation level 조정에 대해 토의

### 12주차

* 2020.11.07, 온라인 세션 (with Zoom)
* create_page_tables 리뷰
* __cpu_setup 분석
* __primary_switch (__enable_mmu, __relocate_kernel RELR relocation apply 직전 까지 진행)
* 다음 주 토의 내용
 * __create_page_tables create_table_entry의 이해.
 * __enable_mmu 내부
   * phys_to_ttbr 매크로CONFIG_ARM64_PA_BITS_52 가 적용 될 때의 동작 이해
   * offset_to_ttbr1 매크로CONFIG_ARM64_VA_BITS_52가 적용 될 때의 동작 이해

### 13주차

* 2020.11.14, 온라인 세션 (with Zoom)
  * __relocate_kernel 내 RELR relocations
  * __primary_switched 내 __pi_memset 까지 진행

* 다음 주 진행 내용
  * KASAN 개념
  * kasan_early_init 부터 start_kernel
  * BPF 실습(다음주 또는 다다음주) - 윤여름님께서 공유해주실 예정

* 향후 스터디 시작 후/저녁 식사 후/스터디 마무리 시간에 자유롭게 질의하는 시간을 갖고자 합니다. 이미 진행한 내용에 대해서도 자유롭게 질문해 주셔도 되니 진도 상황에 관계없이 자유롭게 얘기해주세요

### 14주차

* 2020.11.21, 온라인 세션 (with Zoom)
  * PLT & GOT
    * https://bpsecblog.wordpress.com/2016/03/07/about_got_plt_1/
  * Fixmap
    * http://jake.dothome.co.kr/fixmap/
  * KASLR
    * https://www.workofard.com/2016/05/kaslr-in-the-arm64-kernel/
    * 2GB 보정 이유
    * b2eed9b58811283d00fa861944cb75797d4e52a7
    * KALSR 중 Offset 이용한 범위 지정에 대해 논의

* 다음 주 진행 내용
  * module_range, module_alloc_base 및 21 비트 사용 이유에 대한 논의
    ```
    /*
		 * Randomize the module region by setting module_alloc_base to
		 * a PAGE_SIZE multiple in the range [_etext - MODULES_VSIZE,
		 * _stext) . This guarantees that the resulting region still
		 * covers [_stext, _etext], and that all relative branches can
		 * be resolved without veneers.
		 */
		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
		module_alloc_base = (u64)_etext + offset - MODULES_VSIZE;
    module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
  	module_alloc_base &= PAGE_MASK;
    ```

### 15주차, 2020.11.28
* 온라인 세션 (with Zoom), 7명 참석
* start_kernel ~ cgroup_init_early 까지 분석 진행
* 코드 리딩
  * 페이지 테이블 생성 (__create_page_tables) 및 커널 재배치 (__relocate_kernel) 코드 리딩 - 박영준님
  * module_range, module_alloc_base 및 21비트 사용 이유에 대한 내용 공유 - 윤여름님
    * module area에서 커널 stext ~ etext 공간에 접근 가능하도록 설계한 개념 전달
* 논의 내용
  * set_task_stack_and_magic() 에서 최초 커널 스택 마지막에 magic value를 기록하는 이유와 overflow가 발생하는 일이 있는가?
    * scheduler에서 magic value를 체크하여 스택이 corrupted 되었는지 확인
  * cgroup은 무엇이고 어떻게 사용하는가?
    * https://hwwwi.tistory.com/12
    * 실제 docker ID == cgroup ID 로 실습 내용 공유 - 박영준님
  * inline assembly 에서의 "memory" 의미
    * memory barrier 의 의미로 해석
    * http://jake.dothome.co.kr/inline-assembly/
    * https://wiki.kldp.org/KoreanDoc/html/EmbeddedKernel-KLDP/app3.basic.html
  * mrs_s, msr_s 등의 매크로에서 __emit_inst가 어떻게 사용되는 것인지
    * .inst directive에서 opcode 로 사용(https://sourceware.org/binutils/docs/as/ARM-Directives.html)
    * arm64 관련 opcode: https://github.com/CAS-Atlantic/AArch64-Encoding/blob/master/AArch64_ops.pdf

* 다음주 진도 및 논의 내용
  * local_irq_disable() 부터 분석 진행