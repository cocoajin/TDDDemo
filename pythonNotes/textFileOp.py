#!/usr/bin/python

'text file write or read'

import os

#current path file
fname=''
ls=os.linesep

while True:
	print '$$$$$ please select file operation\n'+'(1)read a text file'
	print '(2)write to a text file\n'+'(x)exit the op'
	op=raw_input('select op=')
	if op=='x':
		print 'closed'
		break
		
	#read a text file
	elif op=='1':
		print 'read op,please input file name'
		iname=raw_input('filename=')
		fname='./'+iname
		if os.path.exists(fname)==False:
			print "file not exist in",fname
		try:
			fobj=open(fname,'r')
		except IOError,e:
			print '** file open error:',e
		else:
			for eachline in fobj:
				print eachline,
			fobj.close()
			print 'read file completed'
	
	#write a text file		
	elif op=='2':
		all=[]
		print 'write op,please input file name'
		iname=raw_input('filename=')
		fname='./'+iname
		print "Enter text ... when '.' quit"
		while True:
			en=raw_input('>')
			if en=='.':
				break
			else:
				all.append(en)
		
		fobj=open(fname,'w')
		fobj.writelines(['%s%s' % (x,ls) for x in all])
		fobj.close()
		print 'File Write complete'


	else:
		print 'select error,not 1,2 or x'
		
	
	