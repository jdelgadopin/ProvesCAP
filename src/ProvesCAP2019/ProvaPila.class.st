"
Please c
"
Class {
	#name : #ProvaPila,
	#superclass : #Object,
	#category : #ProvesCAP2019
}

{ #category : #'as yet unclassified' }
ProvaPila class >> provaPila [
	| pila index |
	pila := OrderedCollection new.
	index := 0.
	^ { 
	[ pila := OrderedCollection new. index := 0. pila ] .
	[ index > 0 ifTrue: [ index := index - 1. pila removeLast ] 
					ifFalse: [ ProvaPila error: 'Pila Buida' ] ] .
	[ :elem | index := index + 1. pila add: elem. ] .
	[ index ] .
	[ index = 0 ] .
	[ pila ]
	 }
]
