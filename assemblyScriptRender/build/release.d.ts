/** Exported memory */
export declare const memory: WebAssembly.Memory;
/** assembly/index/offset */
export declare const offset: {
  /** @type `usize` */
  get value(): number
};
/**
 * assembly/index/update
 * @param tick `f32`
 */
export declare function update(tick: number): void;
/**
 * assembly/index/resize
 * @param w `i32`
 * @param h `i32`
 */
export declare function resize(w: number, h: number): void;
