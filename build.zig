const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("tiny-regex", .{});

    const lib = b.addLibrary(.{
        .name = "tiny-regex",
        .linkage = .static,
        .root_module = b.createModule(.{
            .target = b.standardTargetOptions(.{}),
            .optimize = b.standardOptimizeOption(.{}),
            .strip = true,
            .link_libc = true,
        }),
    });

    _ = b.addModule("libtiny-regex", .{
        .root_source_file = upstream.path("re.c"),
        .link_libc = true,
    });

    lib.addCSourceFile(.{
        .file = upstream.path("re.c"),
    });

    b.installArtifact(lib);
}
