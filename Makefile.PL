use inc::Module::Install;

name           'Devel-SubTrace';
all_from       'lib/Devel/SubTrace.pm';

build_requires 'IPC::Open3'    => 0;

license 'perl';
githubmeta;
author_tests('xt');
readme_from 'lib/Devel/SubTrace.pm';

WriteAll;
