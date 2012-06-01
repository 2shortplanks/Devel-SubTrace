use inc::Module::Install;

name           'Devel-TraceSub';
all_from       'lib/Devel/TraceSub.pm';

build_requires 'IPC::Open3'    => 0;

license 'perl';
githubmeta;
author_tests('xt');
readme_from 'lib/Devel/TraceSub.pm';

WriteAll;
