"use strict";

function soundMaker(sound, times) {
	// things like sound and times defined outside the scope of the nested functions like makeSound are known as free variables

	// closure --> a function nested inside another function that uses a variable from the parent function that wasn't defined inside the lower scope
	// love it this is how scope is defined in Javascript makes sense
	// every function has three levels of scope
	// local scope --> things passed directly into it as arguments and things defined inside its scope/function block
	// 
	// parent scope --> anything that was already defined in the parent scope is accessible to the
	// children functions - does this include global variables? likely
	// defining variables in places outside that child's scope
	// a closure that uses a free variable is called capturing that free variable
	// interesting a closure can change a free variable and it'll be permanently changed outside
	// its scope as well very interesting
	function makeSound() {
		console.log(`${sound}`);
	}

	for(let i = 0; i < times; i++) { // yeah you remember this amazing definitely get back up to speed with this language for sure
		makeSound();
	}
}

// soundMaker("woof", 5); // fascinating so everything in the function just happens immediately as you call it makes sense


function summation(arr) {
	let sum = 1;

	// closure
	function summer() {
		for(let i = 0; i < arr.length; i++) {
			sum *= arr[i];
		}
	}

	summer();

	return sum;
}

console.log(summation([1, 2, 3, 4, 10, 24]));

// one of the most common uses for a closure is for a callback
// the key thing to note about closures is that when you change
// a variable inside a closure, it also changes that variable's value


// one of the most common use cases for closures are callbacks
// a callback is just a function that is passed to another function as an argument
// that is intended to be called at a later time can you do this in Ruby hmm

// a common use case of this is when a function doesn't have access to the
// variables it needs until a later date, common with asynchronous code

// async functions will keep going, doesn't wait for a task to be completed, callbacks, awesome
// callbacks are common with I/O, timers, AJAX requests, and for event handlers, love it

// super glad to understand that and know what that is already

// event handlers just wait for something to happen and then execute things, runs everything else
// in the meantime, and that's a callback, love it

// setTimeout defined for us inside the global scope with Javascript with two diff variables depending on
// if we're client side or server side
// client side, it's window.setTimeout, server side, it's global.setTimeout

// so server side you can see global, you can see everything defined at the global scope
// window is basically client side global

// don't make global variables as usual

// .setTimeout(callback, timeToWait); --> amazing it takes a callback (a code to run later at a different date) and an amount of time to wait before calling it amazing

// learn the difference between a const and a let etc

let callback_func = function() {
	console.log("It has been 5 seconds!"); // console.log is like print/puts
}
let timeToWait = 5000; // ms
global.setTimeout(callback_func, timeToWait);

// more likely to see is the shorthand with an anonymous function awesome

// ES5 syntax, not ES6 syntax, look into what the difference is
global.setTimeout(function() {console.log("It has been 2 seconds!");}, 2000);

// amazing these run asynchronously so this second one will print out before the first function it doesn't even call it

// ah amazing know the difference between saying callback_func versus callback_func(),
// you can't pass say callback_func() into the .setTimeout() as an argument because it expects
// a callback function object, and callback_func is a callback function object, callback_func() is the OUTPUT of INVOKING the callback_func object,
// aka its return value, not the whole function as a whole. Pretty cool that you can do that in JS tbh
// So always pass in the object of the callback_func object itself, not the *output* of the callback_func

// Learn how to teach like JS from books that's brilliant actually definitely make your own curriculum that way awesome

// ES6 syntax
// preferred syntax though they both work --> this just says () is an anonymous function
// with an arrow to the code for the anonymous function block code awesome like so:
global.setTimeout(() => console.log("It has been 3.456 seconds!"), 3456);


// ES6 long syntax
// This is how you do anonymous functions that are arbitrarily long blocks awesome
global.setTimeout(() => {
	console.log("It has been 4.5 seconds!");
}, 4500);


// summary - that's cool, a recap at the end does help --> have some way to verify
// people actually finish each video each day and have a quiz at the end of all
// material each day for people to answer to make sure they actually understand
// everything, do a ton of work here to make sure people understand it, quizzes
// on all the content for sure. Love figuring out how to make a curriculum better
// and to keep aiming to get people to really understand stuff


