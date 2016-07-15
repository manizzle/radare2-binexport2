; Input	MD5   :	ADDE5C63DAFFAB89BEBA8C074BF88761
; Input	CRC32 :	31CCB97E

; File Name   :	C:\Users\Dave\IdeaProjects\radare2-binexport2\sample-files\fauxware
; Format      :	ELF64 for x86-64 (Executable)
; Imagebase   :	400000
; Interpreter '/lib64/ld-linux-x86-64.so.2'
; Needed Library 'libc.so.6'
;
; Source File :	'crtstuff.c'
; Source File :	'fauxware.c'

		.686p
		.mmx
		.model flat
.intel_syntax noprefix

; ===========================================================================

; Segment type:	Pure code
; Segment permissions: Read/Execute
_init		segment	dword public 'CODE' use64
		assume cs:_init
		;org 4004E0h
		assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


		public _init_proc
_init_proc	proc near		; CODE XREF: __libc_csu_init+40p
		sub	rsp, 8		; _init
		call	call_gmon_start
		call	frame_dummy
		call	__do_global_ctors_aux
		add	rsp, 8
		retn
_init_proc	endp

_init		ends

; ===========================================================================

; Segment type:	Pure code
; Segment permissions: Read/Execute
_plt		segment	para public 'CODE' use64
		assume cs:_plt
		;org 400500h
		assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing
		dq 2 dup(?)
; [00000006 BYTES: COLLAPSED FUNCTION _puts. PRESS CTRL-NUMPAD+	TO EXPAND]
		dw ?
		dq ?
; [00000006 BYTES: COLLAPSED FUNCTION _printf. PRESS CTRL-NUMPAD+ TO EXPAND]
		dw ?
		dq ?
; [00000006 BYTES: COLLAPSED FUNCTION _read. PRESS CTRL-NUMPAD+	TO EXPAND]
		dw ?
		dq ?
; [00000006 BYTES: COLLAPSED FUNCTION ___libc_start_main. PRESS	CTRL-NUMPAD+ TO	EXPAND]
		dw ?
		dq ?
; [00000006 BYTES: COLLAPSED FUNCTION _strcmp. PRESS CTRL-NUMPAD+ TO EXPAND]
		dw ?
		dq ?
; [00000006 BYTES: COLLAPSED FUNCTION _open. PRESS CTRL-NUMPAD+	TO EXPAND]
		dw ?
		dq ?
; [00000006 BYTES: COLLAPSED FUNCTION _exit. PRESS CTRL-NUMPAD+	TO EXPAND]
		dw ?
		dq ?
_plt		ends

; ===========================================================================

; Segment type:	Pure code
; Segment permissions: Read/Execute
_text		segment	para public 'CODE' use64
		assume cs:_text
		;org 400580h
		assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn

		public _start
_start		proc near
		xor	ebp, ebp
		mov	r9, rdx		; rtld_fini
		pop	rsi		; argc
		mov	rdx, rsp	; ubp_av
		and	rsp, 0FFFFFFFFFFFFFFF0h
		push	rax
		push	rsp		; stack_end
		mov	r8, offset __libc_csu_fini ; fini
		mov	rcx, offset __libc_csu_init ; init
		mov	rdi, offset main ; main
		call	___libc_start_main
		hlt
_start		endp

; ---------------------------------------------------------------------------
		align 4

; =============== S U B	R O U T	I N E =======================================


call_gmon_start	proc near		; CODE XREF: _init_proc+4p
		sub	rsp, 8
		mov	rax, cs:__gmon_start___ptr
		test	rax, rax
		jz	short loc_4005BE
		call	rax ; __gmon_start__

loc_4005BE:				; CODE XREF: call_gmon_start+Ej
		add	rsp, 8
		retn
call_gmon_start	endp

; ---------------------------------------------------------------------------
		align 10h

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

__do_global_dtors_aux proc near		; CODE XREF: _term_proc+4p
		push	rbp
		mov	rbp, rsp
		push	rbx
		sub	rsp, 8
		cmp	cs:completed_6531, 0
		jnz	short loc_40062D
		mov	ebx, offset __DTOR_END__
		mov	rax, cs:dtor_idx_6533
		sub	rbx, offset __DTOR_LIST__
		sar	rbx, 3
		sub	rbx, 1
		cmp	rax, rbx
		jnb	short loc_400626
		nop	word ptr [rax+rax+00h]

loc_400608:				; CODE XREF: __do_global_dtors_aux+54j
		add	rax, 1
		mov	cs:dtor_idx_6533, rax
		call	ds:__DTOR_LIST__[rax*8]
		mov	rax, cs:dtor_idx_6533
		cmp	rax, rbx
		jb	short loc_400608

loc_400626:				; CODE XREF: __do_global_dtors_aux+30j
		mov	cs:completed_6531, 1

loc_40062D:				; CODE XREF: __do_global_dtors_aux+10j
		add	rsp, 8
		pop	rbx
		pop	rbp
		retn
__do_global_dtors_aux endp

; ---------------------------------------------------------------------------
		align 20h

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

frame_dummy	proc near		; CODE XREF: _init_proc+9p
		cmp	cs:__JCR_LIST__, 0
		push	rbp
		mov	rbp, rsp
		jz	short loc_400660
		mov	eax, 0
		test	rax, rax
		jz	short loc_400660
		pop	rbp
		mov	edi, offset __JCR_LIST__
		jmp	rax
; ---------------------------------------------------------------------------

loc_400660:				; CODE XREF: frame_dummy+Cj
					; frame_dummy+16j
		pop	rbp
		retn
frame_dummy	endp

; ---------------------------------------------------------------------------
		align 4

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

		public authenticate
authenticate	proc near		; CODE XREF: main+91p

s1		= qword	ptr -20h
file		= qword	ptr -18h
buf		= byte ptr -10h
var_8		= byte ptr -8
fd		= dword	ptr -4

		push	rbp
		mov	rbp, rsp
		sub	rsp, 20h
		mov	[rbp+file], rdi
		mov	[rbp+s1], rsi
		mov	[rbp+var_8], 0
		mov	rdx, cs:sneaky
		mov	rax, [rbp+s1]
		mov	rsi, rdx	; s2
		mov	rdi, rax	; s1
		call	_strcmp
		test	eax, eax
		jnz	short loc_400699
		mov	eax, 1
		jmp	short locret_4006EB
; ---------------------------------------------------------------------------

loc_400699:				; CODE XREF: authenticate+2Cj
		mov	rax, [rbp+file]
		mov	esi, 0		; oflag
		mov	rdi, rax	; file
		mov	eax, 0
		call	_open
		mov	[rbp+fd], eax
		lea	rcx, [rbp+buf]
		mov	eax, [rbp+fd]
		mov	edx, 8		; nbytes
		mov	rsi, rcx	; buf
		mov	edi, eax	; fd
		call	_read
		lea	rdx, [rbp+buf]
		mov	rax, [rbp+s1]
		mov	rsi, rdx	; s2
		mov	rdi, rax	; s1
		call	_strcmp
		test	eax, eax
		jnz	short loc_4006E6
		mov	eax, 1
		jmp	short locret_4006EB
; ---------------------------------------------------------------------------

loc_4006E6:				; CODE XREF: authenticate+79j
		mov	eax, 0

locret_4006EB:				; CODE XREF: authenticate+33j
					; authenticate+80j
		leave
		retn
authenticate	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

		public accepted
accepted	proc near		; CODE XREF: main+A5p
		push	rbp
		mov	rbp, rsp
		mov	edi, offset s	; "Welcome to the admin	console, trusted u"...
		call	_puts
		pop	rbp
		retn
accepted	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: noreturn bp-based	frame

		public rejected
rejected	proc near		; CODE XREF: main+B1p
		push	rbp
		mov	rbp, rsp
		mov	eax, offset format ; "Go away!"
		mov	rdi, rax	; format
		mov	eax, 0
		call	_printf
		mov	edi, 1		; status
		call	_exit
rejected	endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl main(int argc, const char	**argv,	const char **envp)
		public main
main		proc near		; DATA XREF: _start+1Do

var_40		= qword	ptr -40h
var_34		= dword	ptr -34h
var_24		= dword	ptr -24h
var_20		= byte ptr -20h
var_18		= byte ptr -18h
buf		= byte ptr -10h
var_8		= byte ptr -8

		push	rbp
		mov	rbp, rsp
		sub	rsp, 40h
		mov	[rbp+var_34], edi
		mov	[rbp+var_40], rsi
		mov	[rbp+var_8], 0
		mov	[rbp+var_18], 0
		mov	edi, offset aUsername ;	"Username: "
		call	_puts
		lea	rax, [rbp+buf]
		mov	edx, 8		; nbytes
		mov	rsi, rax	; buf
		mov	edi, 0		; fd
		call	_read
		lea	rax, [rbp+var_24]
		mov	edx, 1		; nbytes
		mov	rsi, rax	; buf
		mov	edi, 0		; fd
		call	_read
		mov	edi, offset aPassword ;	"Password: "
		call	_puts
		lea	rax, [rbp+var_20]
		mov	edx, 8		; nbytes
		mov	rsi, rax	; buf
		mov	edi, 0		; fd
		call	_read
		lea	rax, [rbp+var_24]
		mov	edx, 1		; nbytes
		mov	rsi, rax	; buf
		mov	edi, 0		; fd
		call	_read
		lea	rdx, [rbp+var_20]
		lea	rax, [rbp+buf]
		mov	rsi, rdx
		mov	rdi, rax
		call	authenticate
		mov	[rbp+var_24], eax
		mov	eax, [rbp+var_24]
		test	eax, eax
		jz	short loc_4007C9
		mov	eax, 0
		call	accepted
		jmp	short locret_4007D3
; ---------------------------------------------------------------------------

loc_4007C9:				; CODE XREF: main+9Ej
		mov	eax, 0
		call	rejected
; ---------------------------------------------------------------------------

locret_4007D3:				; CODE XREF: main+AAj
		leave
		retn
main		endp

; ---------------------------------------------------------------------------
		align 20h

; =============== S U B	R O U T	I N E =======================================


; void _libc_csu_init(void)
		public __libc_csu_init
__libc_csu_init	proc near		; DATA XREF: _start+16o

var_30		= qword	ptr -30h
var_28		= qword	ptr -28h
var_20		= qword	ptr -20h
var_18		= qword	ptr -18h
var_10		= qword	ptr -10h
var_8		= qword	ptr -8

		mov	[rsp+var_28], rbp
		mov	[rsp+var_20], r12
		lea	rbp, cs:600E24h
		lea	r12, cs:600E24h
		mov	[rsp+var_18], r13
		mov	[rsp+var_10], r14
		mov	[rsp+var_8], r15
		mov	[rsp+var_30], rbx
		sub	rsp, 38h
		sub	rbp, r12
		mov	r13d, edi
		mov	r14, rsi
		sar	rbp, 3
		mov	r15, rdx
		call	_init_proc
		test	rbp, rbp
		jz	short loc_400846
		xor	ebx, ebx
		nop	dword ptr [rax+00h]

loc_400830:				; CODE XREF: __libc_csu_init+64j
		mov	rdx, r15
		mov	rsi, r14
		mov	edi, r13d
		call	qword ptr [r12+rbx*8]
		add	rbx, 1
		cmp	rbx, rbp
		jnz	short loc_400830

loc_400846:				; CODE XREF: __libc_csu_init+48j
		mov	rbx, [rsp+38h+var_30]
		mov	rbp, [rsp+38h+var_28]
		mov	r12, [rsp+38h+var_20]
		mov	r13, [rsp+38h+var_18]
		mov	r14, [rsp+38h+var_10]
		mov	r15, [rsp+38h+var_8]
		add	rsp, 38h
		retn
__libc_csu_init	endp

; ---------------------------------------------------------------------------
		align 10h

; =============== S U B	R O U T	I N E =======================================


; void _libc_csu_fini(void)
		public __libc_csu_fini
__libc_csu_fini	proc near		; DATA XREF: _start+Fo
		rep retn
__libc_csu_fini	endp

; ---------------------------------------------------------------------------
		align 20h

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

__do_global_ctors_aux proc near		; CODE XREF: _init_proc+Ep
		push	rbp
		mov	rbp, rsp
		push	rbx
		sub	rsp, 8
		mov	rax, cs:__CTOR_LIST__
		cmp	rax, 0FFFFFFFFFFFFFFFFh
		jz	short loc_4008AF
		mov	ebx, offset __CTOR_LIST__
		nop	dword ptr [rax+rax+00h]

loc_4008A0:				; CODE XREF: __do_global_ctors_aux+2Dj
		sub	rbx, 8
		call	rax ; __CTOR_LIST__
		mov	rax, [rbx]
		cmp	rax, 0FFFFFFFFFFFFFFFFh
		jnz	short loc_4008A0

loc_4008AF:				; CODE XREF: __do_global_ctors_aux+14j
		add	rsp, 8
		pop	rbx
		pop	rbp
		retn
__do_global_ctors_aux endp

; ---------------------------------------------------------------------------
		align 8
_text		ends

; ===========================================================================

; Segment type:	Pure code
; Segment permissions: Read/Execute
_fini		segment	dword public 'CODE' use64
		assume cs:_fini
		;org 4008B8h
		assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing

; =============== S U B	R O U T	I N E =======================================


		public _term_proc
_term_proc	proc near
		sub	rsp, 8		; _fini
		call	__do_global_dtors_aux
		add	rsp, 8
		retn
_term_proc	endp

_fini		ends

; ===========================================================================

; Segment type:	Pure data
; Segment permissions: Read
; Segment alignment 'qword' can not be represented in assembly
_rodata		segment	para public 'CONST' use64
		assume cs:_rodata
		;org 4008C8h
		public _IO_stdin_used
_IO_stdin_used	db    1
		db    0
		db    2
		db    0
		db    0
		db    0
		db    0
		db    0
aSosneaky	db 'SOSNEAKY',0         ; DATA XREF: .data:sneakyo
		align 20h
; char s[]
s		db 'Welcome to the admin console, trusted user!',0 ; DATA XREF: accepted+4o
; char format[]
format		db 'Go away!',0         ; DATA XREF: rejected+4o
; char aUsername[]
aUsername	db 'Username: ',0       ; DATA XREF: main+17o
; char aPassword[]
aPassword	db 'Password: ',0       ; DATA XREF: main+4Do
_rodata		ends

; ===========================================================================

; Segment type:	Pure data
; Segment permissions: Read
_eh_frame_hdr	segment	dword public 'CONST' use64
		assume cs:_eh_frame_hdr
		;org 40092Ch
		db    1
		db  1Bh
		db    3
		db  3Bh	; ;
		db  40h	; @
		db    0
		db    0
		db    0
		db    7
		db    0
		db    0
		db    0
		db 0D4h	; �
		db 0FBh	; �
		db 0FFh
		db 0FFh
		db  5Ch	; \
		db    0
		db    0
		db    0
		db  38h	; 8
		db 0FDh	; �
		db 0FFh
		db 0FFh
		db  84h	; �
		db    0
		db    0
		db    0
		db 0C1h	; �
		db 0FDh	; �
		db 0FFh
		db 0FFh
		db 0A4h	; �
		db    0
		db    0
		db    0
		db 0D1h	; �
		db 0FDh	; �
		db 0FFh
		db 0FFh
		db 0C4h	; �
		db    0
		db    0
		db    0
		db 0F1h	; �
		db 0FDh	; �
		db 0FFh
		db 0FFh
		db 0E4h	; �
		db    0
		db    0
		db    0
		db 0B4h	; �
		db 0FEh	; �
		db 0FFh
		db 0FFh
		db    4
		db    1
		db    0
		db    0
		db  44h	; D
		db 0FFh
		db 0FFh
		db 0FFh
		db  2Ch	; ,
		db    1
		db    0
		db    0
_eh_frame_hdr	ends

; ===========================================================================

; Segment type:	Pure data
; Segment permissions: Read
; Segment alignment 'qword' can not be represented in assembly
_eh_frame	segment	para public 'CONST' use64
		assume cs:_eh_frame
		;org 400970h
		db  14h
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    1
		db  7Ah	; z
		db  52h	; R
		db    0
		db    1
		db  78h	; x
		db  10h
		db    1
		db  1Bh
		db  0Ch
		db    7
		db    8
		db  90h	; �
		db    1
		db    0
		db    0
		db  24h	; $
		db    0
		db    0
		db    0
		db  1Ch
		db    0
		db    0
		db    0
		db  70h	; p
		db 0FBh	; �
		db 0FFh
		db 0FFh
		db  80h	; �
		db    0
		db    0
		db    0
		db    0
		db  0Eh
		db  10h
		db  46h	; F
		db  0Eh
		db  18h
		db  4Ah	; J
		db  0Fh
		db  0Bh
		db  77h	; w
		db    8
		db  80h	; �
		db    0
		db  3Fh	; ?
		db  1Ah
		db  3Bh	; ;
		db  2Ah	; *
		db  33h	; 3
		db  24h	; $
		db  22h	; "
		db    0
		db    0
		db    0
		db    0
		db  1Ch
		db    0
		db    0
		db    0
		db  44h	; D
		db    0
		db    0
		db    0
		db 0ACh	; �
		db 0FCh	; �
		db 0FFh
		db 0FFh
		db  89h	; �
		db    0
		db    0
		db    0
		db    0
		db  41h	; A
		db  0Eh
		db  10h
		db  86h	; �
		db    2
		db  43h	; C
		db  0Dh
		db    6
		db    2
		db  84h	; �
		db  0Ch
		db    7
		db    8
		db    0
		db    0
		db  1Ch
		db    0
		db    0
		db    0
		db  64h	; d
		db    0
		db    0
		db    0
		db  15h
		db 0FDh	; �
		db 0FFh
		db 0FFh
		db  10h
		db    0
		db    0
		db    0
		db    0
		db  41h	; A
		db  0Eh
		db  10h
		db  86h	; �
		db    2
		db  43h	; C
		db  0Dh
		db    6
		db  4Bh	; K
		db  0Ch
		db    7
		db    8
		db    0
		db    0
		db    0
		db  1Ch
		db    0
		db    0
		db    0
		db  84h	; �
		db    0
		db    0
		db    0
		db    5
		db 0FDh	; �
		db 0FFh
		db 0FFh
		db  20h
		db    0
		db    0
		db    0
		db    0
		db  41h	; A
		db  0Eh
		db  10h
		db  86h	; �
		db    2
		db  43h	; C
		db  0Dh
		db    6
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  1Ch
		db    0
		db    0
		db    0
		db 0A4h	; �
		db    0
		db    0
		db    0
		db    5
		db 0FDh	; �
		db 0FFh
		db 0FFh
		db 0B8h	; �
		db    0
		db    0
		db    0
		db    0
		db  41h	; A
		db  0Eh
		db  10h
		db  86h	; �
		db    2
		db  43h	; C
		db  0Dh
		db    6
		db    2
		db 0B3h	; �
		db  0Ch
		db    7
		db    8
		db    0
		db    0
		db  24h	; $
		db    0
		db    0
		db    0
		db 0C4h	; �
		db    0
		db    0
		db    0
		db 0A8h	; �
		db 0FDh	; �
		db 0FFh
		db 0FFh
		db  89h	; �
		db    0
		db    0
		db    0
		db    0
		db  51h	; Q
		db  8Ch	; �
		db    5
		db  86h	; �
		db    6
		db  5Fh	; _
		db  0Eh
		db  40h	; @
		db  83h	; �
		db    7
		db  8Fh	; �
		db    2
		db  8Eh	; �
		db    3
		db  8Dh	; �
		db    4
		db    2
		db  58h	; X
		db  0Eh
		db    8
		db    0
		db    0
		db    0
		db  14h
		db    0
		db    0
		db    0
		db 0ECh	; �
		db    0
		db    0
		db    0
		db  10h
		db 0FEh	; �
		db 0FFh
		db 0FFh
		db    2
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
__FRAME_END__	db    0
		db    0
		db    0
		db    0
_eh_frame	ends

; ===========================================================================

; Segment type:	Pure data
; Segment permissions: Read/Write
; Segment alignment 'qword' can not be represented in assembly
_ctors		segment	para public 'DATA' use64
		assume cs:_ctors
		;org 600E28h
__CTOR_LIST__	dq 0FFFFFFFFFFFFFFFFh	; DATA XREF: __do_global_ctors_aux+9r
					; __do_global_ctors_aux+16o
__CTOR_END__	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
_ctors		ends

; ===========================================================================

; Segment type:	Pure data
; Segment permissions: Read/Write
; Segment alignment 'qword' can not be represented in assembly
_dtors		segment	para public 'DATA' use64
		assume cs:_dtors
		;org 600E38h
__DTOR_LIST__	dq 0FFFFFFFFFFFFFFFFh	; DATA XREF: __do_global_dtors_aux+1Eo
					; __do_global_dtors_aux+43r
		public __DTOR_END__
__DTOR_END__	db    0			; DATA XREF: __do_global_dtors_aux+12o
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
_dtors		ends

; ===========================================================================

; Segment type:	Pure data
; Segment permissions: Read/Write
; Segment alignment 'qword' can not be represented in assembly
_jcr		segment	para public 'DATA' use64
		assume cs:_jcr
		;org 600E48h
__JCR_LIST__	dq 0			; DATA XREF: frame_dummyr
					; frame_dummy+19o
_jcr		ends

; ===========================================================================

; Segment type:	Pure data
; Segment permissions: Read/Write
; Segment alignment 'qword' can not be represented in assembly
_got		segment	para public 'DATA' use64
		assume cs:_got
		;org 600FE0h
__gmon_start___ptr dq offset __gmon_start__ ; DATA XREF: call_gmon_start+4r
_got		ends

; ===========================================================================

; Segment type:	Pure data
; Segment permissions: Read/Write
; Segment alignment 'qword' can not be represented in assembly
_got_plt	segment	para public 'DATA' use64
		assume cs:_got_plt
		;org 600FE8h
_GLOBAL_OFFSET_TABLE_ db    ? ;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		db    ?	;
		align 20h
off_601000	dq offset puts		; DATA XREF: _putsr
off_601008	dq offset printf	; DATA XREF: _printfr
off_601010	dq offset read		; DATA XREF: _readr
off_601018	dq offset __libc_start_main ; DATA XREF: ___libc_start_mainr
off_601020	dq offset strcmp	; DATA XREF: _strcmpr
off_601028	dq offset open		; DATA XREF: _openr
off_601030	dq offset exit		; DATA XREF: _exitr
_got_plt	ends

; ===========================================================================

; Segment type:	Pure data
; Segment permissions: Read/Write
; Segment alignment 'qword' can not be represented in assembly
_data		segment	para public 'DATA' use64
		assume cs:_data
		;org 601038h
		public __data_start ; weak
__data_start	db    0			; Alternative name is '__data_start'
					; data_start
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		public __dso_handle
__dso_handle	db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		public sneaky
; char *sneaky
sneaky		dq offset aSosneaky	; DATA XREF: authenticate+14r
_data		ends			; "SOSNEAKY"

; ===========================================================================

; Segment type:	Uninitialized
; Segment permissions: Read/Write
; Segment alignment 'qword' can not be represented in assembly
_bss		segment	para public 'BSS' use64
		assume cs:_bss
		;org 601050h
		assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing
completed_6531	db ?			; DATA XREF: __do_global_dtors_aux+9r
					; __do_global_dtors_aux:loc_400626w
		align 8
dtor_idx_6533	dq ?			; DATA XREF: __do_global_dtors_aux+17r
					; __do_global_dtors_aux+3Cw ...
_bss		ends

; ===========================================================================

; Segment type:	Externs
; extern
		extrn puts@@GLIBC_2_2_5:near
		extrn printf@@GLIBC_2_2_5:near
		extrn read@@GLIBC_2_2_5:near
		extrn __libc_start_main@@GLIBC_2_2_5:near
		extrn strcmp@@GLIBC_2_2_5:near
		extrn open@@GLIBC_2_2_5:near
		extrn exit@@GLIBC_2_2_5:near
; int puts(const char *s)
		extrn puts:near		; DATA XREF: .got.plt:off_601000o
; int printf(const char	*format, ...)
		extrn printf:near	; DATA XREF: .got.plt:off_601008o
; ssize_t read(int fd, void *buf, size_t nbytes)
		extrn read:near		; DATA XREF: .got.plt:off_601010o
; int __cdecl _libc_start_main(int (__cdecl *main)(int,	char **, char **), int argc, char **ubp_av, void (*init)(void),	void (*fini)(void), void (*rtld_fini)(void), void *stack_end)
		extrn __libc_start_main:near ; DATA XREF: .got.plt:off_601018o
; int strcmp(const char	*s1, const char	*s2)
		extrn strcmp:near	; DATA XREF: .got.plt:off_601020o
; int open(const char *file, int oflag,	...)
		extrn open:near		; DATA XREF: .got.plt:off_601028o
; void __noreturn exit(int status)
		extrn exit:near		; DATA XREF: .got.plt:off_601030o
		extrn __gmon_start__:near ; weak ; CODE	XREF: call_gmon_start+10p
					; DATA XREF: .got:__gmon_start___ptro
		extrn _Jv_RegisterClasses ; weak

; ===========================================================================

; Segment type:	Absolute symbols
; abs
		public _edata
_edata		= 601050h
		public _end
_end		= 601060h
		public __bss_start
__bss_start	= 601050h


		end _start
