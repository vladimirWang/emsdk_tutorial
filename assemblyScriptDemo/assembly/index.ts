export function add(a: number, b: number): number {
    return a+b;
}

export function sum(a: number, b: number): number {
    let res = 0;
    for (let i =0;i<1000000;i++) {
        res+=i;
    }
    return a+b;
}