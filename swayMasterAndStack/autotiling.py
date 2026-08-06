#!/usr/bin/env python3

"""
Dependencies: python-i3ipc>=2.0.1 (i3ipc-python)
"""

import argparse
import os
import sys
from functools import partial

from i3ipc import Connection, Event

try:
    from .__about__ import __version__
except ImportError:
    __version__ = "unknown"


def temp_dir():
    return os.getenv("TMPDIR") or os.getenv("TEMP") or os.getenv("TMP") or "/tmp"


def save_string(string, file_path):
    try:
        with open(file_path, "wt") as file:
            file.write(string)
    except Exception as e:
        print(e)


def output_name(con):
    if con.type == "root":
        return None

    if p := con.parent:
        if p.type == "output":
            return p.name
        else:
            return output_name(p)


def switch_splitting(i3, e, debug, outputs, workspaces, depth_limit, splitwidth, splitheight, splitratio):
    try:
        con = i3.get_tree().find_focused()
        num_windows = len(con.workspace().leaves())

        # Master and stack function (somewhat, not really)
        if num_windows < 1:
            return
        elif num_windows == 1: 
            new_layout = "splith"
        else:
            new_layout = "splitv"

        if new_layout != con.parent.layout:
                result = i3.command(new_layout)
                if result[0].success and debug:
                        print(f"Debug: Switched to {new_layout}", file=sys.stderr)
                elif debug:
                        print(f"Error: Switch failed with err {result[0].error}", file=sys.stderr)

    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)


def get_parser():
    parser = argparse.ArgumentParser(prog="autotiling", description="Script for sway and i3 to automatically switch the horizontal / vertical window split orientation")

    parser.add_argument("-d", "--debug", action="store_true",
                        help="print debug messages to stderr")
    parser.add_argument("-v", "--version", action="version",
                        version=f"%(prog)s {__version__}, Python {sys.version}",
                        help="display version information")
    parser.add_argument("-o", "--outputs", nargs="*", type=str, default=[],
                        help="restricts autotiling to certain output; example: autotiling --output  DP-1 HDMI-0")
    parser.add_argument("-w", "--workspaces", nargs="*", type=str, default=[],
                        help="restricts autotiling to certain workspaces; example: autotiling --workspaces 8 9")
    parser.add_argument("-l", "--limit", type=int, default=0,
                        help='limit how often autotiling will split a container; '
                             'try "2" if you like master-stack layouts; default: 0 (no limit)')
    parser.add_argument("-sw",
                        "--splitwidth",
                        help='set the width of the vertical split (as factor); default: 1.0;',
                        type=float,
                        default=1.0, )
    parser.add_argument("-sh",
                        "--splitheight",
                        help='set the height of the horizontal split (as factor); default: 1.0;',
                        type=float,
                        default=1.0, )
    parser.add_argument("-sr",
                        "--splitratio",
                        help='Split direction ratio - based on window height/width; default: 1;'
                             'try "1.61", for golden ratio - window has to be 61%% wider for left/right split; default: 1.0;',
                        type=float,
                        default=1.0, )

    """
    Changing event subscription has already been the objective of several pull request. To avoid doing this again
    and again, let's allow to specify them in the `--events` argument.
    """
    parser.add_argument("-e", "--events", nargs="*", type=str, default=["WINDOW", "MODE"],
                        help="list of events to trigger switching split orientation; default: WINDOW MODE")

    return parser

def main():
    args = get_parser().parse_args()

    if args.debug:
        if args.outputs:
            print(f"autotiling is only active on outputs: {','.join(args.outputs)}")
        if args.workspaces:
            print(f"autotiling is only active on workspaces: {','.join(args.workspaces)}")

    # For use w/ nwg-panel
    ws_file = os.path.join(temp_dir(), "autotiling")
    if args.workspaces:
        save_string(','.join(args.workspaces), ws_file)
    else:
        if os.path.isfile(ws_file):
            os.remove(ws_file)

    if not args.events:
        print("No events specified", file=sys.stderr)
        sys.exit(1)

    handler = partial(
        switch_splitting,
        debug=args.debug,
        outputs=args.outputs,
        workspaces=args.workspaces,
        depth_limit=args.limit,
        splitwidth=args.splitwidth,
        splitheight=args.splitheight,
        splitratio=args.splitratio
    )
    i3 = Connection()
    for e in args.events:
        try:
            i3.on(Event[e], handler)
            print(f"{Event[e]} subscribed")
        except KeyError:
            print(f"'{e}' is not a valid event", file=sys.stderr)

    i3.main()


if __name__ == "__main__":
    main()
