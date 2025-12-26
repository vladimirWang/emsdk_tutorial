import assert from "assert";
import {sum, add} from '../build/release.js';
// const {add, sum} = await import('../build/release.js');

// const module = await import('./build/release.js');
console.log("Module loaded:", add(1,2));
// console.log("add result: ", module.add(1, 44));
performance.mark('WASM_start')
assert.strictEqual(sum(1, 44), 45);

performance.mark('WASM_end')
performance.measure('WASM_time', 'WASM_start', 'WASM_end')
console.log(performance.getEntriesByName('WASM_time'));
console.log("-----------------------------------")

function jsSum(a, b) {
    let res = 0;
    for (let i =0;i<1000000;i++) {
        res+=i;
    }
    return a+b;
}


performance.mark('js_start')
assert.strictEqual(jsSum(1, 44), 45);

performance.mark('js_end')
performance.measure('js_time', 'js_start', 'js_end')
console.log(performance.getEntriesByName('js_time'));