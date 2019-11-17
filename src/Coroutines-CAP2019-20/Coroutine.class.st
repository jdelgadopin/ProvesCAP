"
After Section 17.6 ""Coroutines: Continuations in Action"" (p.567) of the book ""Scheme and the Art of Programming"", by George Springer and Daniel P. Friedman, MIT Press 1989 (ISBN 0-262-19288-8)
[ http://cs.unm.edu/~williams/cs357/springer-friedman.pdf ]


"
Class {
	#name : #Coroutine,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'savedContinuation',
		'firstTime',
		'resumer',
		'theBlock'
	],
	#category : #'Coroutines-CAP2019-20'
}

{ #category : #examples }
Coroutine class >> example1 [
	"Coroutine example1"
	| a b c |
	a := Coroutine maker: [ :resume :value |
				'This is A' traceCr.
				('Came from ', (resume value: b value: 'A')) traceCr.. 
				'Back in A' traceCr.
				('Came from ', (resume value: c value: 'A')) traceCr ].
	b := Coroutine maker: [ :resume :value |
				'   This is B' traceCr.
				('   Came from ', (resume value: c value: 'B')) traceCr.. 
				'   Back in B' traceCr.
				('   Came from ', (resume value: a value: 'B')) traceCr ].
	c := Coroutine maker: [ :resume :value |
				'      This is C' traceCr.
				('      Came from ', (resume value: a value: 'C')) traceCr.. 
				'      Back in C' traceCr.
				('      Came from ', (resume value: b value: 'C')) traceCr ].
	a value: '*'.

]

{ #category : #'instance creation' }
Coroutine class >> maker: aBlock [
	"Usage: Coroutine maker: [ :resume :value | . . . ] "
	
	^ self new makeCoroutineWith: aBlock
]

{ #category : #'instance creation' }
Coroutine >> initialize [

	firstTime := true.
	savedContinuation := nil.
	resumer := [ :nextCoroutine :value | 
						Continuation callcc: [ :cc | 	savedContinuation := cc.
													      nextCoroutine value: value  ]  ].

]

{ #category : #'instance creation' }
Coroutine >> makeCoroutineWith: aBlock [ 

	theBlock := aBlock.
]

{ #category : #evaluation }
Coroutine >> value: aValue [

	firstTime 	ifTrue: [ firstTime := false.
						 theBlock value: resumer value: aValue ]
		 	   	ifFalse: [ savedContinuation value: aValue  ]
			
]
