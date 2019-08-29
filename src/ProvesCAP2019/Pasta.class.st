"
Please 
"
Class {
	#name : #Pasta,
	#superclass : #Object,
	#instVars : [
		'moneda',
		'quantitat'
	],
	#category : #ProvesCAP2019
}

{ #category : #'instance creation' }
Pasta class >> moneda: unaString quantitat: unNumero [
	^ self new moneda: unaString; quantitat: unNumero
]

{ #category : #accessing }
Pasta >> moneda [
	^ moneda
]

{ #category : #accessing }
Pasta >> moneda: anObject [
	moneda := anObject
]

{ #category : #accessing }
Pasta >> quantitat [
	^ quantitat
]

{ #category : #accessing }
Pasta >> quantitat: anObject [
	quantitat := anObject
]
