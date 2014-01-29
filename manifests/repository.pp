class dropbox::repository {
  case $::operatingsystem {
    /(?i:Debian)/ : {
      apt::repository { 'dropbox':
        url        => "http://linux.dropbox.com/debian",
        distro     => $::lsbdistcodename,
        repository => 'main',
      }
    }
    /(?i:Ubuntu)/ : {
      apt::repository { 'dropbox':
        url        => "http://linux.dropbox.com/ubuntu",
        distro     => $::lsbdistcodename,
        repository => 'main',
      }
    }
    default       : {
      notice("Unknown operating system $::operatingsystem")
    }
  }
}