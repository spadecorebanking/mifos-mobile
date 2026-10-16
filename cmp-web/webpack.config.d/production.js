// Kotlin already eliminates dead code in production executables. Running Terser
// over the large Compose bundle can exhaust CI resources and stall packaging.
if (config.mode === "production") {
    config.optimization = { ...config.optimization, minimize: false };
    config.devtool = false;
}
