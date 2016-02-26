TextLayer = require 'TextLayer'

merge = (A, nA, B, nB, C, n) ->
	i = 0;
	j = 0;
	for k in [0..n]
		# make sure we don't read split arrays out of bounds
		if (i < nA && j < nB) 
			# if element is smaller in first array, then put it to result array
			if (A[i] < B[j]) 
				C[k] = A[i]
				i++
			# if element is smaller (or equal) in second array, then put it to result array
			else if (B[j] <= A[i])
				C[k] = B[j]
				j++
		# if we are in situation where last element is remained
		else 
			# if it's in first array
			if (i < nA)
				C[k] = A[i]
				i++
			# if it's in second array
			if (j < nB) 
				C[k] = B[j]
				j++

mergeSort = (C, n) ->
	# if array size is less than 2 it's sorted already
	if (n < 2)
		return
	
	# split array in two, if uneven count of elements, second array will be larger
	mid = parseInt(n / 2)
	nA = mid
	nB = n - nA
#	print "mid=" + mid + " nA=" + nA + " nB=" + nB + " n=" + n
	A = C[0..nA - 1]
	drawNumbers(A, totalSteps - Math.log2(mid), true)
	B = C[nA..n]
	drawNumbers(B, totalSteps - Math.log2(mid), false)
	# recursively calling to split, sort and merge
	mergeSort(A, nA)
	mergeSort(B, nB)
	# split sorted arrays are merged into one sorted array
	merge(A, nA, B, nB, C, n)


drawNumbers = (numbers, row, left) ->
	print "drawNumbers=" + numbers + " row=" + row  + " A " + left
	xPosition = (Screen.width - numbers.length * numberLayerSize) / 2;
	if left
		xPosition += 0
	else
		xPosition += numbers.length * numberLayerSize
	numbersLayer = new Layer
		backgroundColor: "transparent"
		x: xPosition
		y: row * numberLayerSize + verticalMargin
	for k in [0..numbers.length - 1]
		drawNumber(numbers[k], k, numbersLayer)

drawNumber = (number, i, parentLayer) ->
	numberLayer = new TextLayer
		width: numberLayerSize
		height: numberLayerSize
		x: i * numberLayerSize
		backgroundColor: "#3F51B5"
		color: "#F0F1F8"
		text: number
		fontSize: numberLayerSize * 0.7
		textAlign: "center"
		autoSizeHeight: true
	numberLayer.superLayer = parentLayer


numberLayerSize = 100
verticalMargin = numberLayerSize / 2
bg = new BackgroundLayer
	backgroundColor: "#EFEFEF"

C = [5, 4, 1, 8, 7, 2, 6, 3]
n = C.length
print C
totalSteps = Math.log2(n)

drawNumbers(C, 0)
	
mergeSort(C, n)
print C



