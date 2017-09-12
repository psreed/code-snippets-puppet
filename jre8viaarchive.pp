#Install JRE 8 (Server Edition) from '.tar.gz' in a Windows node via the Puppet Archive Module
#
# This is an example of how to use puppet-archive on windows to extract a .tar.gz
#
# On Linux nodes, the puppet-archive module uses the 'tar' command, which can extract a '.tar.gz' file in a single step.
# On Windows nodes however, puppet-archive uses '7zip' which currently requires a 2-step process for these particular 
# file types (this is a 7zip limitation). There may be other wrapped archive types that may also require this 
# 2-step method on Windows ('.cpio.tar' files maybe?).
#

class profile::windows::jre8viaarchive {

  include archive

  ### Note: If not using chocolatey as the windows provider for packages, install 7zip the default windows way.
  ## You will need to provide a local source for the .msi installer for 7zip.
  #class { 'archive':
  #  seven_zip_name     => '7-Zip 9.20 (x64 edition)',
  #  seven_zip_source   => 'C:/Windows/Temp/7z920-x64.msi',
  #  seven_zip_provider => 'windows',
  #}

  # Step 1: Download and extract the gzip part of the '.tar.gz' which will result in a '.tar' pacakge remaining locally. 
  archive { 'C:\java\server-jre-8u77-windows-x64.tar.gz':
    ensure        => present,
    extract       => true,
    extract_path  => 'C:\Java',
    extract_flags => {'7z' => 'x -aoa'},
    source        => 'http://master:81/jre8/8.0.77/server-jre-8u77-windows-x64.tar.gz',
    checksum      => '9cb0d1389cd5e48bb282d6350e37e905b9e1605e',
    checksum_type => 'sha1',
    creates       => 'C:\Java\server-jre-8u77-windows-x64.tar',
    cleanup       => true,
  } ->
  # Step 2: Extract the local '.tar' package to end up with the fully extracted archive.
  archive { 'C:\java\server-jre-8u77-windows-x64.tar':
    ensure        => present,
    extract       => true,
    extract_path  => 'C:\Java',
    extract_flags => {'7z' => 'x -aoa'},
    source        => 'C:\Java\server-jre-8u77-windows-x64.tar',
    checksum      => 'ce9f78917deb508474b5c50bccb481d97e3562ce',
    checksum_type => 'sha1',
    creates       => 'C:\Java\jdk1.8.0_77\bin\java.exe',
    cleanup       => true,
  }

}
