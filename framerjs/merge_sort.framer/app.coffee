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

mergeSort = (C, n, parentLayer, parentLayerX) ->
	# if array size is less than 2 it's sorted already
	if (n < 2)
		return
	
	# split array in two, if uneven count of elements, second array will be larger
	mid = parseInt(n / 2)
	nA = mid
	nB = n - nA
#	print "mid=" + mid + " nA=" + nA + " nB=" + nB + " n=" + n
	A = C[0..nA - 1]
	aLayer = drawNumbers(A, totalSteps - Math.log2(mid), parentLayerX)
	aLayer.superLayer = parentLayer
	B = C[nA..n]
	bLayer = drawNumbers(B, totalSteps - Math.log2(mid), parentLayerX)
	bLayer.superLayer = parentLayer
	# recursively calling to split, sort and merge
	mergeSort(A, nA)
	mergeSort(B, nB)
	# split sorted arrays are merged into one sorted array
	merge(A, nA, B, nB, C, n)

drawNumbers = (numbers, row, xPosition) ->
	print "drawNumbers=" + numbers + " row=" + row
	numbersLayer = new Layer
		backgroundColor: "transparent"
		x: xPosition
		y: row * numberLayerSize
	for k in [0..numbers.length - 1]
		numberLayer = drawNumber(numbers[k], k, numbersLayer)
		numbersLayer.addSubLayer(numberLayer)
	return numbersLayer

drawNumber = (number, i) ->
	number = new TextLayer
		width: numberLayerSize
		height: numberLayerSize
		x: i * numberLayerSize
		backgroundColor: "#3F51B5"
		color: "#F0F1F8"
		text: number
		fontSize: numberLayerSize * 0.7
		textAlign: "center"
		autoSizeHeight: true
	return number


numberLayerSize = 100
verticalMargin = numberLayerSize / 2
bg = new BackgroundLayer
	backgroundColor: "#EFEFEF"

C = [5, 4, 1, 8, 7, 2, 6, 3]
positions = [0, 0, 0, 0, 0, 0, 0, 0]
n = C.length
print C
totalSteps = Math.log2(n)

position = (Screen.width - n * numberLayerSize) / 2
parentLayer = drawNumbers(C, 0, position)
	
mergeSort(C, n, parentLayer)
print C



