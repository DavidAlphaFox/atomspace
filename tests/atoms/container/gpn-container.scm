;
; gpn-container.scm
; GPNJoinUTest
; Make sure named containers work.

(use-modules (opencog) (opencog exec))

(Evaluation (Predicate "cherry pie") (List (Concept "A")))
(Evaluation (Predicate "hello daddy") (List (Concept "B")))
(Evaluation (Predicate "hello mum") (List (Concept "C")))
(Evaluation (Predicate "ch ch ch cherry bomb") (List (Concept "Runaways")))
(Evaluation (Predicate "cutie pie") (List (Concept "E")))
(Evaluation (Predicate "cake") (List (Concept "F")))
(Evaluation (Predicate "spinach") (List (Concept "G")))
(Evaluation (Predicate "sinister shoes") (List (Concept "Zappa")))

(define (min-like-pie ATOM)
	(define label (cog-name ATOM))
	(format #t "I was minimally told ~A" ATOM)
	(if (string-contains label "pie") (stv 1 1) (stv 0 1)))

(define (max-like-pie ATOM)
	(define pred (cog-outgoing-atom ATOM 0))
	(define label (cog-name pred))
	(format #t "I was maximally told ~A" ATOM)
	(if (string-contains label "pie") (stv 1 1) (stv 0 1)))

(define (like-both-pie PRED EVAL)
	(define pred (cog-outgoing-atom EVAL 0))
	(define label (cog-name pred))
	(format #t "I was told ~A and ~A" PRED EVAL)
	(if (not (equal? PRED pred))
		(throw 'test-failure "like-both-pie" "You blew it!"))
	(if (string-contains label "pie") (stv 1 1) (stv 0 1)))

(define min-gpn
	(MinimalJoin
		(VariableList
			(TypedVariable (Variable "P") (Type 'PredicateNode))
			(TypedVariable (Variable "$top") (Type 'JoinLink)))
		(Evaluation (GroundedPredicate "scm:min-like-pie")
			(List (Variable "$top")))))

(define max-gpn
	(MaximalJoin
		(VariableList
			(TypedVariable (Variable "P") (Type 'PredicateNode))
			(TypedVariable (Variable "$top") (Type 'JoinLink)))
		(Evaluation (GroundedPredicate "scm:max-like-pie")
			(List (Variable "$top")))))

(define both-gpn
	(MaximalJoin
		(VariableList
			(TypedVariable (Variable "P") (Type 'PredicateNode))
			(TypedVariable (Variable "$top") (Type 'JoinLink)))
		(Evaluation (GroundedPredicate "scm:like-both-pie")
			(List (Variable "P") (Variable "$top")))))

(define min-gpn-rep
	(MinimalJoin
		(VariableList
			(TypedVariable (Variable "P") (Type 'PredicateNode))
			(TypedVariable (Variable "$top") (Type 'JoinLink)))
		(Replacement (Variable "P") (Concept "I Like Pie!"))
		(Evaluation (GroundedPredicate "scm:min-like-pie")
			(List (Variable "$top")))))

(define max-gpn-rep
	(MaximalJoin
		(VariableList
			(TypedVariable (Variable "P") (Type 'PredicateNode))
			(TypedVariable (Variable "$top") (Type 'JoinLink)))
		(Replacement (Variable "P") (Concept "I Like Pie!"))
		(Evaluation (GroundedPredicate "scm:max-like-pie")
			(List (Variable "$top")))))

(define both-gpn-rep
	(MaximalJoin
		(VariableList
			(TypedVariable (Variable "P") (Type 'PredicateNode))
			(TypedVariable (Variable "$top") (Type 'JoinLink)))
		(Replacement (Variable "P") (Concept "I Like Pie!"))
		(Evaluation (GroundedPredicate "scm:like-both-pie")
			(List (Variable "P") (Variable "$top")))))
