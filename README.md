# tiny-regex
[tiny-regex-c](https://github.com/kokke/tiny-regex-c) built with Zig.

## Fetch
```sh
$ zig fetch git+https://github.com/doccaico/tiny-regex
```

## How to use
```zig
// build.zig
const tiny_regex = b.dependency("tiny-regex", .{
    .target = target,
    .optimize = optimize,
});
exe.linkLibrary(tiny_regex.artifact("tiny-regex"));
```
