const std = @import("std");
const stdout = std.io.getStdOut().writer();

const Range = struct {
    start: usize,
    end: usize,

    pub fn init(s: []const u8) anyerror!Range {
        var splits = std.mem.split(u8, s, "-");

        var start = try std.fmt.parseInt(usize, splits.next().?, 10);
        var end = try std.fmt.parseInt(usize, splits.next().?, 10);

        return Range{
            .start = start,
            .end = end,
        };
    }

    pub fn contains(self: Range, other: Range) bool {
        return (self.start <= other.start) and (self.end >= other.end);
    }

    pub fn overlaps(self: Range, other: Range) bool {
        var smaller = if (self.start < other.start) self else other;
        var larger = if (self.start < other.start) other else self;

        if ((smaller.start <= larger.start) and (larger.start <= smaller.end)) {
            return true;
        } else if ((smaller.start <= larger.end) and (larger.end <= smaller.end)) {
            return true;
        }

        return false;
    }
};

pub fn main() anyerror!void {
    var file = try std.fs.cwd().openFile("data", .{});
    defer file.close();

    var partOne: usize = 0;
    var partTwo: usize = 0;

    var bufReader = std.io.bufferedReader(file.reader());
    var inStream = bufReader.reader();
    var buf: [1024]u8 = undefined;

    while (try inStream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var splits = std.mem.split(u8, line, ",");

        var first = try Range.init(splits.next().?);
        var second = try Range.init(splits.next().?);

        if (first.contains(second) or second.contains(first)) {
            partOne += 1;
        }

        if (first.overlaps(second)) {
            partTwo += 1;
        }
    }

    try stdout.print("Part one: {d}\n", .{partOne});
    try stdout.print("Part two: {d}\n", .{partTwo});
}
