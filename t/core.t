use Test::More;
use lib 'lib/';

use_ok "Emoji";

is Emoji::do_magic("t/fixtures/epoch.emoji"),"Epoch is : ".time,"Emoji file parsed correctly";

is Emoji::do_magic("t/fixtures/take_dump.emoji"),"\$VAR1 = 'TEST';\n","The poo emoji works";

done_testing();