use Test::More;
use lib 'lib/';

use_ok "Emoji";

is Emoji::do_magic("t/fixtures/epoch.emoji"),"Epoch is : ".time,"Emoji file parsed correctly";

done_testing();