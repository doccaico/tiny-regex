const std = @import("std");
const heap = std.heap;
const process = std.process;

const c = @cImport({
    @cInclude("re.h");
});

var arena: std.heap.ArenaAllocator = undefined;

pub fn main() !void {
    arena = heap.ArenaAllocator.init(heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    // use CURL
    const curl_argv = [_][]const u8{ "curl", "https://example.com" };
    const result = try process.Child.run(.{ .allocator = allocator, .argv = &curl_argv });
    // std.debug.print("{s}\n", .{result.stdout});

    var match_length: i32 = undefined;
    const pattern = c.re_compile("<h1>.*</h1>");

    const match_idx: i32 = c.re_matchp(pattern, result.stdout.ptr, &match_length);
    if (match_idx != -1) {
        std.debug.print("match at idx {d}, {d} chars long.\n", .{ match_idx, match_length });
        const s = result.stdout[@intCast(match_idx) .. @as(usize, @intCast(match_idx)) + @as(usize, @intCast(match_length))];
        std.debug.print("{s}\n", .{s});
    }
}

// OUTPUT
//
// match at idx 959, 23 chars long.
// <h1>Example Domain</h1>
