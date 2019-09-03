"
Please 
"
Class {
	#name : #ProvaClosures,
	#superclass : #Object,
	#category : #ProvesCAP2019
}

{ #category : #'as yet unclassified' }
ProvaClosures class >> provaClosures [
	| comptador resetComptador incComptador valorComptador |
	comptador := 0.
	resetComptador := [ comptador := 0. comptador ].
	incComptador := [ :i | comptador := comptador + i. comptador ].
	valorComptador := [ comptador ].
	^ { resetComptador . incComptador . valorComptador }.
	
]
