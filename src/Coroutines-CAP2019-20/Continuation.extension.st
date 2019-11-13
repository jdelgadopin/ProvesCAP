Extension { #name : #Continuation }

{ #category : #'*Coroutines-CAP2019-20' }
Continuation class >> callcc: aBlock [
	^ self currentDo: aBlock 
]
