class dropbox::repository {
  case $::operatingsystem {
    /(?i:Debian)/ : {
      apt::repository { 'dropbox':
        url        => "http://linux.dropbox.com/debian",
        distro     => $::lsbdistcodename,
        repository => 'main',
        key        => '5044912E',
        keyserver  => 'pgp.mit.edu',
      }
    }
    /(?i:Ubuntu)/ : {
      apt::repository { 'dropbox':
        url        => "http://linux.dropbox.com/ubuntu",
        distro     => $::lsbdistcodename,
        repository => 'main',
        key        => '5044912E',
        keyserver  => 'pgp.mit.edu',
      }
    }
    default       : {
      notice("Unknown operating system $::operatingsystem")
    }
  }
}