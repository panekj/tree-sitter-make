=====================
Rule, targets, single
=====================
target:
%.o:
*.o:

---

(makefile
  (rule
    targets: (list (word)))
  (rule
    targets: (list (word)))
  (rule
    targets: (list (word))))

=======================
Rule, targets, multiple
=======================
target %.o *.o:

---

(makefile
  (rule
    targets: (list (word) (word) (word))))

=====================
Rule, grouped targets
=====================
foo %.n *.o &:

---

(makefile
  (rule
    targets: (list (word) (word) (word))))

====================================
Rule, pre-requisites, normal, single
====================================
target: foo
target: %.c
target: *.d

---

(makefile
  (rule
                 targets: (list (word))
    normal_prerequisites: (list (word)))
  (rule
                 targets: (list (word))
    normal_prerequisites: (list (word)))
  (rule
                 targets: (list (word))
    normal_prerequisites: (list (word))))

======================================
Rule, pre-requisites, normal, multiple
======================================
target: foo %.b c.o

---

(makefile
  (rule
                 targets: (list (word))
    normal_prerequisites: (list (word) (word) (word))))

===================================================================
Rule, pre-requisites, normal, multiple, splited lines, one per line
===================================================================
target: foo\
	%.b\
c.o

---

(makefile
  (rule
                 targets: (list (word))
    normal_prerequisites: (list (word) (word) (word))))

========================================================================
Rule, pre-requisites, normal, multiple, splited lines, multiple per line
========================================================================
target: foo %.b c.o\
	foo %.b c.o\
foo %.b c.o

---

(makefile
  (rule
                 targets: (list (word))
    normal_prerequisites: (list (word) (word) (word)
                                (word) (word) (word)
                                (word) (word) (word))))

========================================
Rule, pre-requisites, order only, single
========================================
foo: | bar

---

(makefile
  (rule
                     targets: (list (word))
    order_only_prerequisites: (list (word))))

===========================================================================
Rule, pre-requisites, order only, multiple, splited line, multiple per line
===========================================================================
target: | foo %.b c.o\
	foo %.b c.o\
foo %.b c.o

---

(makefile
  (rule
                     targets: (list (word))
    order_only_prerequisites: (list (word) (word) (word)
                                    (word) (word) (word)
                                    (word) (word) (word))))

===========================================
Rule, pre-requisites, normal and order-only
===========================================
target: foo \
	bar | baz \
foobar

---

(makefile
  (rule
                     targets: (list (word))
        normal_prerequisites: (list (word) (word))
    order_only_prerequisites: (list (word) (word))))

========================
Rule, recipe, empty rule
========================
target: ;

target:
	

---

(makefile
  (rule
    targets: (list (word))
    (recipe))
  (rule
    targets: (list (word))
    (recipe)))

=========================
Rule, recipe, single line
=========================
target:
	echo "foobar"

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)))))

========================================================
Rule, recipe, single line, custom .RECIPEPREFIX I (TODO)
=========================================================
.RECIPEPREFIX = >

target:
>echo "foobar"

---

; TODO

=========================================================
Rule, recipe, single line, custom .RECIPEPREFIX II (TODO)
=========================================================
.RECIPEPREFIX = a

target:
aecho "foobar"

---

; TODO

==========================================================
Rule, recipe, single line, custom .RECIPEPREFIX III (TODO)
==========================================================
.RECIPEPREFIX = >

target: ;
>echo "foobar"

---

; TODO
; NOTE: This code is valid


===========================================
Rule, recipe, single line, suppress echoing
===========================================
target:
	@echo "foobar"

target: ; @echo "foobar"

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text))))
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)))))

================================================================================
Rule, recipe, single line, NOT comment
================================================================================
target:
	# foo

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)))))

===================================
Rule, recipe, single line, splitted
===================================
target:
	echo "foo\
bar"

target:
	echo "foo\
	bar"

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text))))
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text)))))

===================================================
Rule, recipe, single line, splited, supress echoing
===================================================
target:
	@echo "foo\
bar"

target:
	@echo "foo\
	bar"

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text))))
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text)))))

==========================================
Rule, recipe, single line, splited, escape
==========================================
target:
	@echo "\\foo\
	bar"

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text)))))

============================
Rule, recipe, multiple lines
============================
target:
	foo
	bar
	baz

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text))
      (recipe_line
        (shell_text))
      (recipe_line
        (shell_text)))))

================================================================
Rule, recipe, attached to targets-and-prerequisites, single line
================================================================
target: ; echo "foobar"

target: ;
	echo "foobar"

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text))))
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)))))

=========================================================================
Rule, recipe, attached to targets-and-prerequisites, single line, splited
=========================================================================
target: ; echo "foo\
bar"

target: ; echo "foo\
	bar"

---


(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text))))
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text)))))

===================================================================
Rule, recipe, attached to targets-and-prerequisites, multiple lines
===================================================================
target: ; @echo "foo\
bar"

target: ; @echo "foo\
	bar"

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text))))
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text)))))

=========================
Rule, recipe, blank lines
=========================
target:

	echo "foo\
	bar\
bar"

	
	echo "foobar"

target: ;

	@echo "foo\
	bar\
bar"

	echo "foobar"

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text)
        (shell_text))
      (recipe_line
        (shell_text))))
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text)
        (shell_text)
        (shell_text))
      (recipe_line
        (shell_text)))))

======================================
Rule, recipe, multiple lines, comments
======================================
target:

	foo
# comment
	baz

---

(makefile
  (rule
    targets: (list (word))
    (recipe
      (recipe_line
        (shell_text))
      (comment)
      (recipe_line
        (shell_text)))))

================================
Rule, recipe, automatic variable
================================
%.o: %.c
	gcc -c -o $@ $<

---

(makefile
  (rule
                 targets: (list (word))
    normal_prerequisites: (list (word))
    (recipe
      (recipe_line
        (shell_text
          (automatic_variable)
          (automatic_variable))))))

===================================================================
Rule, recipe, automatic variable, file and directory names variants
===================================================================
foo : bar/lose
	cd $(@D)
	gobble ${@F} > ../$@

---

(makefile
  (rule
    targets: (list
      (word))
    normal_prerequisites: (list
      (word))
    (recipe
      (recipe_line
        (shell_text
          (automatic_variable)
          (automatic_variable)
          (automatic_variable))))))

=======================================================
Rule, recipe, automatic variable, secondary expansion I
=======================================================
foo: foo.1 bar.1 $$< $$^ $$+

---

(makefile
  (rule
                 targets: (list (word))
    normal_prerequisites: (list
      (word)
      (word)
      (automatic_variable)
      (automatic_variable)
      (automatic_variable))))

========================================================
Rule, recipe, automatic variable, secondary expansion II
========================================================
%oo: $$< $$^ $$+ $$*

---

(makefile
  (rule
    targets: (list (word))
    normal_prerequisites: (list
      (automatic_variable)
      (automatic_variable)
      (automatic_variable)
      (automatic_variable))))

==============
Rule, complete
==============
target: prereq | prereq2
	recipe

---

(makefile
  (rule
                 targets: (list (word))
    normal_prerequisites: (list (word))
    order_only_prerequisites: (list (word))
    (recipe
      (recipe_line
        (shell_text)))))

====================
Rule, static pattern
====================
foo.o bar.o: %.o: %.c

---

(makefile
  (rule
                 targets: (list (word) (word))
          target_pattern: (word)
    prerequisite_pattern: (list (word))))

