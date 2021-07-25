.pragma library

function truncate(word, len, prefix) {
	if (word.length > len){
		prefix = prefix || ""
		return word.slice(0, len/2)+ "..." + word.slice(-len/2, word.length) + prefix
	}
	return word
}

function getExtension(filename){
	if (filename.includes(".")) return "."+filename.split(".").slice(-1)
	return ""
}

function filenameFromUrl(filename){
//	filename = filename.toString()
	if (filename.includes("/")) return filename.split("/").slice(-1)
	return filename
}

function digit(num, d_){
	num = ""+num
	if (num.length < d_){
		return "0".repeat(d_-num.length)+num
	}
	return num
}
