"
Please 
"
Class {
	#name : #ProvaHaltIf,
	#superclass : #Object,
	#category : #ProvesCAP2019
}

{ #category : #mock }
ProvaHaltIf >> bar [
	^ (self foo), 'bar'
]

{ #category : #mock }
ProvaHaltIf >> foo [
	self haltIf: #bar.
	^ 'foo'
]
