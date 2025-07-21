const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("tiny-regex", .{});

    const lib = b.addLibrary(.{
        .name = "tiny-regex",
        .linkage = .static,
        .root_module = b.createModule(.{
            .target = b.standardTargetOptions(.{}),
            .optimize = b.standardOptimizeOption(.{}),
            .link_libc = true,
        }),
    });

    lib.addCSourceFile(.{
        .file = upstream.path("re.c"),
    });

    lib.installHeader(upstream.path("re.h"), "re.h");

    b.installArtifact(lib);
}
