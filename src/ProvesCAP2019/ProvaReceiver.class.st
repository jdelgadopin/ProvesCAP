"
Please 
"
Class {
	#name : #ProvaReceiver,
	#superclass : #Object,
	#category : #ProvesCAP2019
}

{ #category : #'as yet unclassified' }
ProvaReceiver >> provaReceiver [
	^ (thisContext receiver == self) 
]
