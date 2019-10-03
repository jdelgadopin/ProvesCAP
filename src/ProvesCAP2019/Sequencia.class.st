"
Please 
"
Class {
	#name : #Sequencia,
	#superclass : #Object,
	#instVars : [
		'seq'
	],
	#category : #ProvesCAP2019
}

{ #category : #'instance creation' }
Sequencia class >> with: aString [
	aString asUppercase checkContents ifFalse: [ self error: 'Seqüència mal formada'  ].
	^ self new with: aString asUppercase
]

{ #category : #'as yet unclassified' }
Sequencia >> benFormada: aSeq [
	| mida tmpseq1 tmpseq2 |
	mida := (self seq size) min: (aSeq seq size).
	tmpseq1 := self seq truncateTo: mida.
	tmpseq2 := aSeq seq truncateTo: mida.
	tmpseq1 with: tmpseq2 do: [ :c1 :c2 | (c1 check: c2) ifFalse: [ ^false ] ].
	^ true 
]

{ #category : #accessing }
Sequencia >> seq [
	^ seq
]

{ #category : #'instance creation' }
Sequencia >> with: aString [
	seq := aString
	
]
