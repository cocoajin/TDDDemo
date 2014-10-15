
"student score value"


score=0.0

while True:
	print 'please input your score'
	input=raw_input('score=')
	score=float(input)
	if input.isdigit()==False:
		print 'not a num'
		continue
		
	elif score>=90.0 and score<=100:
		print 'A'
		continue
	
	elif 80.0<=score<=89:
		print 'B'
		continue
	
	elif 70.0<=score<=79:
		print 'C'
		continue
	
	elif 60.0<=score<69:
		print 'D'
		continue
		
	elif score <60:
		print 'F'
		continue
		
	else:
		print 'score is invalid'
		continue
	