"
A CuaAmbPrioritat is xxx

Instance Variables
	vector:		<Object>

vector
	- xxxxx

"
Class {
	#name : #CuaAmbPrioritat,
	#superclass : #Object,
	#instVars : [
		'vector'
	],
	#category : #ProvesCAP2019
}

{ #category : #'public interface' }
CuaAmbPrioritat >> afegir: anElement [

	vector addLast: anElement.
	self surar: (self mida)
]

{ #category : #'public interface' }
CuaAmbPrioritat >> afegirTots: aCollection [
	"Suposarem que aCollection té elements del tipus adeqüat"
	aCollection do: [ :each | self afegir: each ]
	
]

{ #category : #'public interface' }
CuaAmbPrioritat >> buida [
	^ self mida = 0
]

{ #category : #private }
CuaAmbPrioritat >> enfonsar: aNumber [
	| n c |
	n := self mida.
	c := aNumber * 2.
	(c <= n) ifTrue: [ 
				((c + 1 <= n) and: [ (vector at: (c+1)) < (vector at: c) ]) ifTrue: [ c := c + 1 ].
				(vector at: aNumber) > (vector at: c)  ifTrue: [ 
							vector swap: aNumber with: c.
							self enfonsar: c  ] ]

]

{ #category : #initialization }
CuaAmbPrioritat >> initialize [
	super initialize.
	
	vector := OrderedCollection new.
]

{ #category : #'public interface' }
CuaAmbPrioritat >> mida [
	^ vector size
]

{ #category : #'public interface' }
CuaAmbPrioritat >> minim [
	^ vector at: 1.
]

{ #category : #private }
CuaAmbPrioritat >> surar: aNumber [
	(aNumber ~= 1 and: [(vector at: (aNumber // 2)) > (vector at: aNumber) ])
		ifTrue: [  vector swap: aNumber with: (aNumber // 2).
					self surar: (aNumber // 2)	]
]

{ #category : #'public interface' }
CuaAmbPrioritat >> treureMin [
	| x s |
	s := self mida.
	x := vector at: 1.
	vector at: 1 put: (vector at: s).
	vector removeLast.
	self enfonsar: 1.
	^ x 
]
