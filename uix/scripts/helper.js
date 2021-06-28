function createQObject(parent, component, props) {
	props = props || {}
	let obj = component.createObject(parent, props);
	return obj
}
