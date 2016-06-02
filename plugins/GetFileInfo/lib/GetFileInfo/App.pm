package GetFileInfo::App;
use strict;
use URI::Escape;
use MT::FileInfo;

sub _hdlr_get_file_info {
    my $app = shift;

    my $url = uri_unescape( $app->param('url') );
    my $fileinfo = MT::FileInfo->load({ url => $url });

    if ($fileinfo) {
        my $blog_id = $fileinfo->blog_id;
        my $id = $fileinfo->entry_id;
        my $class;

        if ($fileinfo->archive_type eq 'Individual') {
            $class = 'entry';
        } elsif ($fileinfo->archive_type eq 'Page') {
            $class = 'page';
        } else {
            return $app->json_error('Not Entry or Webpage.');
        }

        return $app->json_result({
            class => $class,
            blog_id => $blog_id,
            id => $id
        });
    }

    return $app->json_error('Data Not Found.');
}

1;
