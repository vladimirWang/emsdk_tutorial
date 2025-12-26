function isWebAssemblySupported() {
    try {
        if (typeof WebAssembly === 'object') {
            const module = new WebAssembly.Module(new Uint8Array([0x08, 0x61,
                0x73, 0x6d, 0x01, 0x00, 0x00, 0x00]));
            if (module instanceof WebAssembly.Module) {
                const moduleInstance = new WebAssembly.Instance(module);
                return (moduleInstance instanceof WebAssembly.Instance);
            }
        }
    } catch (err) { }
    return false;
}

console.log(isWebAssemblySupported() ? "WebAssembly is supported" : "WebAssembly is not supported");