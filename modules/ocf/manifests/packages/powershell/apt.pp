# Include PowerShell apt repo
class ocf::packages::powershell::apt {
  apt::key { 'powershell repo key':
    id     => 'BC528686B50D79E339D3721CEB3E94ADBE1229CF',
    source => 'https://packages.microsoft.com/keys/microsoft.asc';
  }
  if $::lsbdistcodename == 'buster' {
    apt::source { 'powershell':
      architecture => 'amd64',
      location     => '[arch=amd64,arm64,armhf] https://packages.microsoft.com/debian/10/prod',
      release      => 'buster',
      repos        => 'main',
      require      => Apt::Key['powershell repo key'],
    }
  } else {
    apt::source { 'powershell':
      architecture => 'amd64',
      location     => '[arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod',
      release      => 'stretch',
      repos        => 'main',
      require      => Apt::Key['powershell repo key'],
    }
  }
}
