#!/usr/bin/env perl    

# copied from http://tex.stackexchange.com/questions/62232/generating-a-single-tex-file-by-merging-different-tex-files

### change the
sub p_inc {
  $DateiName = shift;
    if ( open (my $datei, "$DateiName.tex") ) {
      print "%%%---------- open: ", $DateiName, "\n";
      while (<$datei>) {
        if ((/^\s*\\include{\s+(\S+)/i) or (/^\s*\\input{\s+(\S+)/i)) {
          my $include = $1;
          chomp($include);chop($include);
          print "%%%%%%%%% jump to ", $include, "\n";
          p_inc($include);
        } else { print unless /^\s*(#|$)/; }
      }
      print "%%%---------- close: ", $DateiName, "\n";
      close $datei;
    } else {
      print "%%%<===== file doesn't exist\n";
      die "ERROR: file doesn't exist:".$DateiName.".tex\n";
    }
}
#
@zeilen = (<>);
for $zeile (@zeilen) {
  next if $zeile =~ /^\s*(%)/;
  if (($zeile =~ /^\s*\\include{\s*(\S+)/i) or ($zeile =~ /^\s*\\input{\s*(\S+)/i)) {      
    my $include = $1;
    chomp($include);
    chop($include);
    print "%%%%%%%%%%% jump to ", $include, "\n";
    p_inc($include);
  } else { print $zeile; }
} 