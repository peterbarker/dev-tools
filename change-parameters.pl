#!/usr/bin/perl -w

# this is a filter which changes text of the format
#
#        self.set_parameter("SERVO1_MIN", 1480)  # unlikely
#        self.set_parameter("SERVO1_MAX", 1480)  # bad
#        self.set_parameter("SERVO1_TRIM", 1480)  # also bad
#
# and returns the text:
#
#        self.set_parameters({
#            "SERVO1_MIN": 1480,  # unlikely
#            "SERVO1_MAX": 1480,  # bad
#            "SERVO1_TRIM": 1480,  # also bad
#        })
#
# the latter code from ArduPilot's autotest suite is implemented in a
# much more efficient manner than former
#
# Useful in emacs as a filter:
# - select a region (ctrl-space then move point) containing whole lines to change
# - M-1 Alt-| ~/bin/change-parameters.pl
#
# (that's "replace buffer without output of following, followed by shell-command-on-region followed by the command)

my $first = 1;
my $first_ws;

while (defined (my $line = <>)) {
  if ($line !~ s/(\s+)self.set_parameter\(([^,]+)\s*,\s*([^)]+)\)/$1    $2: $3,/) {
    die "Failed to sub ($line)";
  }
  if ($first) {
    $first_ws = $1;
    print("${first_ws}self.set_parameters({\n");
    $first = 0;
  }
  print($line)
}

print("${first_ws}})\n")
