var util = require('util')

var mega = 1024 * 1024

function simulate() {
	var a = []
	for (var i = 0; i < mega; i++) {
		a.push(i)
	}
}

console.log('Node version: ' + process.version)
console.log('Current memory usage:')
console.log(util.inspect(process.memoryUsage()))
var iterations = process.env.TEST_ITERATIONS || 128
console.log('Running ' + iterations + ' simulations...')

for (var i = 0; i < iterations; i++) {
	simulate()
}

console.log('Completed.')
console.log('Current memory usage:')
console.log(util.inspect(process.memoryUsage()))
