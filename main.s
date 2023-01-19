	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	get_string
	.type	get_string, @function
get_string:
	push	rbp	
	push	rbx			#char c
	push	r15			#*test
	push	r14			#char *s
	push	r13			#capacity
	push	r12			#*len
	mov	rbp, rsp
	mov	r12, rdi		#go to func int *len
	mov	r15, rsi		#go to func int *test
	mov	rax, r12
	mov	DWORD PTR [rax], 0		#*len = 0
	mov	rax, r15
	mov	DWORD PTR [rax], 0		#*test = 0
	mov	r13, 1
	mov	edi, 1				#capacit = 1
	call	malloc@PLT
	mov	r14, rax		#char *s
	call	getchar@PLT
	mov	bl, al		#char c 
	jmp	.L2
.L4:
	mov	rax, r12
	mov	eax, DWORD PTR [rax]
	lea	ecx, 1[rax]
	mov	rdx, r12
	mov	DWORD PTR [rdx], ecx
	movsx	rdx, eax
	mov	rax, r14
	add	rdx, rax
	movzx	eax, bl
	mov	BYTE PTR [rdx], al
	mov	rax, r12
	mov	eax, DWORD PTR [rax]
	cmp	r13, rax
	jg	.L3
	sal	r13
	mov	rax, r13
	movsx	rdx, eax
	mov	rax, r14
	mov	rsi, rdx
	mov	rdi, rax
	call	realloc@PLT
	mov	r14, rax
.L3:
	call	getchar@PLT
	mov	bl, al
.L2:
	cmp	bl, 10
	jne	.L4
	mov	rax, r12
	mov	eax, DWORD PTR [rax]
	movsx	rdx, eax
	mov	rax, r14
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	rax, r14			#return s
	mov	rsp, rbp
	pop	r12
	pop 	r13
	pop	r14
	pop	r15
	pop	rbx
	pop	rbp
	ret
	.size	get_string, .-get_string
	.globl	task
	.type	task, @function
task:
	push	rbp
	push	r12			#*s
	push	r13			#len
	push	r14			#i
	push	r15
	mov	rbp, rsp
	sub	rsp, 32
	mov	r12, rdi		#char *s 
	mov	r13, rsi		#int len
	mov	r14, 0		#int i = 0
	jmp	.L7
.L10:
	mov	rax, r14
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 97
	je	.L8
	mov	rax, r14
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 101
	je	.L8
	mov	rax, r14
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 105
	je	.L8
	mov	rax, r14
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 111
	je	.L8
	mov	rax, r14
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 117
	je	.L8
	mov	rax, r14
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 121
	jne	.L9
.L8:
	mov	rax, r14
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	lea	ecx, -32[rax]
	mov	rax, r14
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
.L9:
	mov	rax, r14
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
	add	r14, 1
.L7:
	mov	rax, r14
	cmp	rax, r13
	jl	.L10
	mov	edi, 10
	call	putchar@PLT
	nop
	mov	rsp,rbp					#void func
	pop	r15
	pop	r14
	pop	r13
	pop	r12
	pop	rbp
	ret
	.size	task, .-task
	.section	.rodata
.LC0:
	.string	"incorrect input"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	lea	rdx, -16[rbp]			#test to get_string
	lea	rax, -12[rbp]			#len to get_string
	mov	rsi, rdx
	mov	rdi, rax
	call	get_string
	mov	QWORD PTR -8[rbp], rax		#save *s from get_string
	mov	eax, DWORD PTR -16[rbp]
	test	eax, eax
	jne	.L12
	mov	edx, DWORD PTR -12[rbp]		#len to task
	mov	rax, QWORD PTR -8[rbp]		#s to task
	mov	esi, edx
	mov	rdi, rax
	call	task				#void func
	mov	eax, 0
	jmp	.L14
.L12:
	lea	rdi, .LC0[rip]			#incorrect input
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L14:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
