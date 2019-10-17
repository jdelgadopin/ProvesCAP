Extension { #name : #SequenceableCollection }

{ #category : #'*ProvesCAP2019' }
SequenceableCollection >> injectRecFirst: aValue into: aFunction [
	^ self isEmpty 
			ifTrue: [ aValue ]
			ifFalse: [ self allButFirst injectRecFirst: (aFunction value: aValue value: self first) into: aFunction ].


]

{ #category : #'*ProvesCAP2019' }
SequenceableCollection >> injectRecLast: aValue into: aFunction [
	^ self isEmpty 
			ifTrue: [ aValue ]
			ifFalse: [ aFunction value: (self allButLast injectRecLast: aValue into: aFunction) value: self last ]

]
