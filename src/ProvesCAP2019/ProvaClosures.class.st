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
	| comptador |
	^ { [ comptador := 0. comptador ] . [ :i | comptador := comptador + i. comptador ] . [ comptador ] }.
	
]
