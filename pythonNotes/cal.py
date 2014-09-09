
# cal prpgramm
avg=0
sums=0
op=0
while str(op)!='x':
	print '-- select operation'
	print '(1)sum of 5 num'
	print '(2)avg of 5 num'
	print '(x)close'
	op=raw_input('op=')
	if op=='x':
		print 'closed'
	elif op.isdigit()==False:
		print 'select Error'
	elif int(op)==1:
		count=0
		while count<5:
			n=raw_input('input num%d='%(count+1))
			if n.isdigit()==False:
				print 'input error!'
				continue
			count+=1 
			sums+=int(n)
			if int(count)==5:
				print '***** sums=',sums
				print ' '
	elif int(op)==2:
		sums=0
		count=0
		while count<5:
			n=raw_input('input num%d='%(count+1))
			if n.isdigit()==False:
				print 'input error!'
				continue
			count+=1 
			sums+=int(n)
			if int(count)==5:
				print '***** avg=',float(sums)/5
				print ' '

			
			