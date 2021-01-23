# 최신 ARM64 리눅스 커널 분석

## 커뮤니티: IAMROOT 17차 7조

* [jake.dothome.co.kr][#moonc] | 문c 블로그
* [www.iamroot.org][#iamroot] | IAMROOT 홈페이지

[#iamroot]: http://www.iamroot.org
[#moonc]: http://jake.dothome.co.kr

## 기타

* [커널 분석 환경 구성](https://www.notion.so/chaoxifer/39d4558faccf499591258b010b6aac28)
* [커널 디버깅 환경 구성](https://github.com/seokbeomKim/iamroot_17th_B/tree/master/aarch64_dev)

## History

<details><summary>1주차, 오리엔테이션</summary>
<p>
* 2020.08.22, 온라인 세션 (with Zoom)
* [오리엔테이션](./20200822/orientation.md)
</p>
</details>

<details><summary>이론 스터디 (2W ~ 5W)</summary>
<p>
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

</p>
</details>

<details><summary>head.S (6W ~ 14W)</summary>
<p>

### 6주차

* 2020.09.26, 온라인 세션 (with Zoom)

* Kernel 소스 분석: head.S

  * 커널 및 U-Boot 부트로더 이용한 소스 코드 분석
  * 2.1 ~ 2.1.3 (CPU 부트 모드 저장)
  * Kernel (v5.8.11)
  * U-Boot (master: 1da91d9bcd6e5ef046c1df0d373d0df87b1e8a72)

* 분석 소스코드: https://github.com/seokbeomKim/iamroot_17th_group7/tree/20200926
* 추석 연휴인 관계로 다음 스터디는 10/10일에 진행됩니다.

* 부트로더(u-boot)에서 EFI pe entry 부분을 설정 및 파싱
  - [EFI boot from u-boot to kernel
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
  * BPF 실습

* 향후 스터디 시작 후/저녁 식사 후/스터디 마무리 시간에 자유롭게
  질의하는 시간을 갖고자 합니다. 이미 진행한 내용에 대해서도 자유롭게
  질문해 주셔도 되니 진도 상황에 관계없이 자유롭게 얘기해주세요

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

</p>
</details>

<details><summary>start_kernel (15W ~ )</summary>
<p>
### 15주차, 2020.11.28

* 온라인 세션 (with Zoom), 7명 참석
* start_kernel ~ cgroup_init_early 까지 분석 진행
* 코드 리딩
  * 페이지 테이블 생성 (__create_page_tables) 및 커널 재배치 (__relocate_kernel) 코드 리딩
  * module_range, module_alloc_base 및 21비트 사용 이유에 대한 내용 공유
	* module area에서 커널 stext ~ etext 공간에 접근 가능하도록 설계한 개념 전달
* 논의 내용
  * set_task_stack_and_magic() 에서 최초 커널 스택 마지막에 magic
	value를 기록하는 이유와 overflow가 발생하는 일이 있는가?
	* scheduler에서 magic value를 체크하여 스택이 corrupted 되었는지 확인
  * cgroup 은 무엇이고 어떻게 사용하는가?
	* [https://hwwwi.tistory.com/12](https://hwwwi.tistory.com/12)
	* 실제 docker ID == cgroup ID 로 실습 내용 공유
  * inline assembly 에서의 "memory" 의미
	* memory barrier 의 의미로 해석
	* [문c 블로그 - Inline Assembly](http://jake.dothome.co.kr/inline-assembly/)
	* [KLDP - Inline Assembly](https://wiki.kldp.org/KoreanDoc/html/EmbeddedKernel-KLDP/app3.basic.html)
  * mrs_s, msr_s 등의 매크로에서 __emit_inst가 어떻게 사용되는 것인지
	* .inst directive에서 opcode 로 사용: [ARM-Directives](https://sourceware.org/binutils/docs/as/ARM-Directives.html)
	* arm64 관련 opcode: [AArch64 OPCODES](https://github.com/CAS-Atlantic/AArch64-Encoding/blob/master/AArch64_ops.pdf)

* 다음주 진도 및 논의 내용
  * local_irq_disable() 부터 분석 진행

### 16주차, 2020.12.05

* 온라인 세션 (with Zoom), 7명 참석
* 논의 내용
  * mrs vs. mrs_s vs. __mrs_s
  * p4d_t 타입이 있는 이유: x86 계열에서는 Level 5 까지의 페이지
	테이블을 지원하지만 ARM에서는 Level4 까지밖에 지원하지 못하므로
	임시로 p4d를 만들어 관리하고 있고 실제 `p4d_offset(pgdp, addr)`을
	살펴보면 pgdp 를 단순히 반환하는 것으로 확인할 수 있다.
  * alternative 개념

* 다음 주 진도 및 논의 내용
  * IRQ Descriptor & KPTI 개념 정리
  * 코드 분석 (local_irq() ~)

### 17주차, 2020.12.12

* 온라인 세션 (with Zoom), 7명 참석
* 논의 내용
  * IRQ Descriptor & KPTI 개념 정리
  * crash 확인 방법, ARM 에서의 NMI
  * LTO에 따른 visible attribute 필요한 이유
	* __attribute((externally_visible))
	* LTO(Link Time Optimization) 기능을 사용하는 경우
	  caller(호출측)와 callee(피호출측)의 관계에서 링커가 callee가 한
	  번만 사용된다고 판단되는 경우 caller에 callee를 inline화 하여
	  집어 넣는데 이 때문에 링킹이 안되는 문제가 발생함 수 있다.

	* Externally_Visible

	  This attribute, attached to a global variable or function,
	  nullifies the effect of the -fwhole-program command-line option,
	  so the object remains visible outside the current compilation
	  unit. If -fwhole-program is used together with -flto and gold is
	  used as the linker plugin, externally_visible attributes are
	  automatically added to functions (not variable yet due to a
	  current gold issue) that are accessed outside of LTO objects
	  according to resolution file produced by gold. For other linkers
	  that cannot generate resolution file, explicit
	  externally_visible attributes are still necessary.

  * Meltdown & Spectre 보안 회피 위해 ARM64에서 사용하는 기법
	(KASLR & KPTI 사용하는 이유)
	* [https://www.programmersought.com/article/11512728259/](https://www.programmersought.com/article/11512728259/)

  * init_mm.brk = _end 의미
	* 커널에서의 brk 의미 상 할당을 해놓은 것으로 _end설정 이후에 변할 일이 없음

  * lm_alias와 virt_to_phys 관계 (주석 내용)

* 다음 주 진도
  * Device Tree, start_kernel ~ IRQ INIT 정리
	* [https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3](https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3)
  * 다음 주까지 lisa
	qemu[https://futurewei-cloud.github.io/ARM-Datacenter/assets/presentations/lisa-qemu-presentation.pdf](https://futurewei-cloud.github.io/ARM-Datacenter/assets/presentations/lisa-qemu-presentation.pdf)
	로 직접 arm64 커널을 디버깅할 수 있도록 환경
	구성해보겠습니다. 나중에 직접 커널 디버깅을 해보면서 함께 분석하기
	위해서라도 미리 해보면 좋을 것 같습니다.

### 18주차, 2020.12.19

* 온라인 세션 (with Zoom), 9명 참석
* 논의 내용
  * Device Tree 기본 내용 및 Interrupt, Interrupt Controller 관련 DT 내용 정리
  * x86에서의 device tree 사용
  * device tree 에서의 overlay(?)

* 이론 스터디
  ([http://jake.dothome.co.kr/linux_5/](http://jake.dothome.co.kr/linux_5/))
  * ARM64 Page Table Mapping
  * 처음에 32비트로 진행했었는데 64비트 쪽도 함께 진행하겠습니다.

* 다음 주 진도
  * setup_arch()
	* early_fixmap_init()
	* early_ioremap_init()
	* setup_machine_fdt(__fdt_pointer)

### 19주차, 2020.12.26

* 온라인 세션 (with Zoom), 6명 참석

* 논의 내용
  * early ioremap vs. 정규 ioremap의 차이점
    * fixmap (early ioremap) 또는 vmalloc (정규 ioremap) 사용에 따른 차이
  * likely() unlikely()에서 단순하게 레이블로 jmp 것을 비용이 크다고 하는 이유가 무엇인가?
    * https://lwn.net/Articles/412072/ - trace point 가 disable된 경우는 비교 자체가 유의미 하지 않으니까, cost를 0로 만들어 주겠다는 것

* paging_init 이전에 memblock 초기화 하는 이유
  * fixmap을 사용하는 이유는 fixmap영역에 swapper_pg_dir을 temp 처럼 mapping 시켜놓고 사용하려는 의도
  * early ioremap은 paging_init 이전에 디바이스가 메모리에 접근해야 하는 케이스에 대해서 보장하기 위해 사용
  * arm64_memblock_init은 reserved 용으로 사용하며, paging_init 이후에도 정규 할당자를 바로 사용할 수 없기 때문에 paging_init 이후에도 바로 사용할 수 있는 memblock을 여러 subsystem에서 사용
    * http://jake.dothome.co.kr/arm64_memblock_init/
    * http://jake.dothome.co.kr/map64/

* 논의 필요한 내용
  * paging_init 전에 efi 정보를 얻어와야 하는 이유 (논의 필요)
  * paging_init을 early_fixmap_init(), 이후에 하는 이유?
  그냥 paging_init을 미리 하고 fixmap init을 해도 되지 않을까? (논의 필요)

* 이론 스터디
  * ([http://jake.dothome.co.kr/linux_5/](http://jake.dothome.co.kr/linux_5/))
  * ARM64 Page Table Mapping (2장)

* 다음 주 진도
  * jump_label_init()
  * ARM64 Page Table Mapping (3장)

### 20주차, 2020.01.02

* 스터디 미 진행 (연휴)

### 21주차, 2020.01.09

* lisa-qemu 이용한 커널 디버깅 환경 구성
  * 커널만 따로 빌드하여 이미지 업데이트 가능하도록 개선 요구
  * GDB layout 에서의 vertical 기능 지원
    * 에디터에서 GDB 통합 플러그인 지원
  * $kernel_dev/linux/src/scripts/package/builddeb 에서 아래 부분 주석 처리
    ```
	# create_package "$dbg_packagename" "$dbg_dir"
    ```

* 논의 내용
  * always_inline
    * compiler에 의해 inline이 되지 않는 경우에도 항상 inline이 될 수 있도록
	강제하기 위한 속성 (함수에 에러가 있다고 진단되거나 최적화 옵션에 따라
	inline되지 않을 수 있다.)

  * BUILD_BUG_ON 으로 컴파일 타임에 ATOMIC_INIT 으로 테스트 하는 이유
    * 다른 아키텍처에서 locking issue 가 있어 추가한 것으로서 ARM64의 경우는
    한번 초기화 된 이후로 바로 return되므로 불필요한 부분이다.

  * JUMP_LABEL_NOP 만 jump table에서 초기화하는 이유
    * 컴파일러로부터의 nops와 실제 어셈 레벨에서 구현되는 nops 가 다름
    * ARM nops instruction 크기
    * 인텔의 경우 5바이트가 JMP 사이즈, nop이 1바이트부터 8바이트까지 가능(각각
      의미가 있는 실제 인스트럭션이지만 nop처럼 사용할 수 있음),
    * binutil(컴파일러)이 만드는 multi byte nop이랑 intel 레퍼런스 문서에서
      추천하는 multi byte nop이 다르다. 때문에, binutil이 만든 multi byte nop을
      intel 레퍼런스 버젼으로 변환해 주는데, binutil 버젼은 nop에 레지스터
      의존성이 있어서 속도가 더 느리다.
	* https://stackoverflow.com/questions/25545470/long-multi-byte-nops-commonly-understood-macros-or-other-notation
    * http://mail.openjdk.java.net/pipermail/hotspot-compiler-dev/2010-September/003882.html

  * cache bouncing ldrex/strex 이전에 먼저 읽어 확인 후 정상일 때 기록 시도하는
    것이 어떻게 cache bouncing 문제를 해결하는지 논의 - 차주 다시 논의 필요
	* 관련 링크: http://jake.dothome.co.kr/exclusive-loads-and-store/
	* WFE (kernel v3.18 대) 참고
    * 현재는 ldrex/strex 대신에 qspinlock 사용

### 22주차, 2020.01.16

* 커널 분석
  * parse_early_param () ~
  * do_early_param callback 함수를 통해 boot cmdline 파싱 및 초기화
  * linux/init.h - early_param 으로 boot 인자 전달 받아 드라이버에서 처리할 수 있음
  * boot_command_line - fdt 로부터 읽어서 설정 (chosen)

* 논의 내용
  * mcount: http://blog.daum.net/tlos6733/129
  * ldrex & strex, MCS Lock, ticketing lock

* 이론
  * BKL
  * Exclusive loads and store

* 다음 주 진도
  * local_daif_restore() ~
  * memblock 이론 정리 및 zone allocator 공부

### 23주차, 2020.01.23

* 커널 분석 & 이론
  * local_daif_restore () ~ arm64_memblock_init () 이전
  * memblock
    - http://jake.dothome.co.kr/memblock-1/
    - http://jake.dothome.co.kr/memblock-2/
* I2C H/W Specification 세미나

* 논의 내용
  * .mmuoff.data.write 코멘트
    * 위치: $linux/arch/arm64/kernel/vmlinux.lds.S::.mmuoff.data.write
    * MMUOFF에서 사용할 데이터를 읽는 이유와 읽을 때 invalidate 를 해줘야 하는 이유
      * https://patchwork.kernel.org/project/linux-arm-kernel/patch/1472059650-591-3-git-send-email-james.morse@arm.com/

* GIC Interrupt
  * 키보드 인터럽트가 한 코어에서만 잡힌다면 해당 인터럽트가 PPI로서 GIC에서 기술되어서인지? NO.
    - PPI는 프로세서에 특정된 인터럽트만 기술하며 일반적으로 주변장치의 인터럽트는 SPI로 등록
    - https://sunshout.tistory.com/1474#:~:text=PPI%20(Private%20Peripheral%20Interrupt)%20%3A,writing%20to%20a%20GICD_SGIR%20register

* memory allocator가 early 단계와 아닌 단계로 나눠지는 이유
  - SMP 환경에서 쓸 수 있는 메모리 할당자를 위해 충분히 초기화 되지 않았기 때문
  - $Linux/Documentation/core-api/boot-time-mm.rst 참고

* __tlbi 에서 alternative 코드 들어간 이유
  - 관련 커밋 참고: https://github.com/torvalds/linux/commit/d9ff80f83ecbf4cbdf56d32d01c312498e4fb1cd

* memblock 에서 physmem 은 사용 아예 안하는가
  - struct memblock 에만 제거되었으며 특정 아키텍처를 위해 Kconfig 및 API는 남겨두고 있음

</p>
</details>
