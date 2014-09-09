
# sort three num

count=0

print 'please input three num for sort'

while count <3:
	print 'please input num%d'%(count+1)
	input=raw_input('num%d='%(count+1))
	if input.isdigit()==False:
		print 'input error, not a num'
		continue
	count+=1
	if count==1:
		num1=input
		#print 'num1 is',num1
	elif count==2:
		num2=input 
		#print 'num2 is',num2
	elif count==3:
		num3=input
		#print 'num3 is',num3
		print 'input end ---  the Three num is : ',num1,num2,num3
		
		#sort the nums
		print 'please select the sort type'
		print '(1) sort by desc' #jiang xu
		print '(2) sort by asc'	#sheng xu
		print '(x) exit'
		selectSucced=False
		while selectSucced==False:
			sortType=raw_input('select=')	
			if sortType=='x':
				print 'exit the sort'
				selectSucced=True
			elif sortType.isdigit()==False:
				print 'select error, not a num'
				selectSucced=False
				continue
			elif int(sortType)>2 or int(sortType)<0 :
				print 'select error,not 1 or 2'
				selectSucced=False
				continue
			elif int(sortType)==1:
				print 'sort by dest'
				temp=0
				temp1=num1
				temp2=num2
				temp3=num3
				if temp1<temp2:
					temp=temp1
					temp1=temp2
					temp2=temp
				if temp2 <temp3:
					temp=temp2
					temp2=temp3
					temp3=temp
				if temp1 < temp2:
					temp=temp1
					temp1=temp2
					temp2=temp
				
				print 'result is',temp1,temp2,temp3
				#selectSucced=True
				
			elif int(sortType)==2:
				print 'sort by asc'
				temp1=int(num1)
				temp2=int(num2)
				temp3=int(num3)
				if temp1>temp2:
					temp1=temp1^temp2
					temp2=temp2^temp1
					temp1=temp1^temp2
				if temp2 >temp3:
					temp2=temp2^temp3
					temp3=temp3^temp2
					temp2=temp2^temp3
				if temp1 > temp2:
					temp1=temp1^temp2
					temp2=temp2^temp1
					temp1=temp1^temp2
				
				print 'result is',temp1,temp2,temp3
				#selectSucced=True

#python 两个数的交换可使用
# x,y = y,x 直接交换
				
				
				