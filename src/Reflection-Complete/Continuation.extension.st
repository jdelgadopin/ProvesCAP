Extension { #name : #Continuation }

{ #category : #'*Reflection-Complete' }
Continuation class >> callcc: aBlock [
	^ self currentDo: aBlock
]
