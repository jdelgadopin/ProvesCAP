"
Please 
"
Class {
	#name : #PastaTest,
	#superclass : #TestCase,
	#instVars : [
		'eur5',
		'eur10',
		'eur20'
	],
	#category : #ProvesCAP2019
}

{ #category : #initialization }
PastaTest >> setUp [
	eur5  :=  Pasta new moneda: 'EUR'; quantitat: 5.
	eur10 :=  Pasta new moneda: 'EUR'; quantitat: 10.
	eur20 :=  Pasta new moneda: 'EUR'; quantitat: 20.
]

{ #category : #tests }
PastaTest >> testIguals [
	self assert: eur10 = (Pasta new moneda: 'EUR'; quantitat: 10).
	self assert: eur20 ~= eur10.

]
