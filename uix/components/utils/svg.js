.pragma library

function fromString(svg){
	return "data:image/svg+xml;utf8, " + svg.join('')
}
