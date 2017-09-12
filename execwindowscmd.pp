#Run an arbitrary windows command using puppet exec
class execwindowscmd {

  ######################################
  # Windows cmd.exe example (may not work on future versions of windows)
  ######################################

  exec { 'javarun':
    cwd       => 'C:\\Program Files (x86)\\Java\\jre1.8.0_144\\bin',
    creates   => 'C:\\javaran.txt',
    command   => 'cmd.exe /c "C:\\Program Files (x86)\\Java\\jre1.8.0_144\\bin\\java.exe" -version > C:\\javaran.txt 2>&1',
    path      => ['C:\\Windows\\System32']
  }

  ######################################
  # Pure Powershell Example
  ######################################
  #
  # Note: java.exe (and javac.exe) prints it's version string to STDERR instead of STDOUT like most programs do
  #       For this reason, we are using -RedirectStandardError instead of -RedirectStandardOutput in the command.
  #       Keep in mind that powershell does not support redirecting both STDERR and STDOUT to the same output file.

  $pspath     = 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0'
  $psargs     = '-NoProfile -NoLogo -NonInteractive'
  $powershell = "${pspath}\\powershell.exe ${psargs}"
  $javapath   = 'C:\\Program Files (x86)\\Java\\jre1.8.0_144\\bin'
  $java       = "${javapath}\\java.exe"
  $javaargs   = '-version'
  $outfile    = 'C:\\javaranps.txt'
  $pscmd      = "Start-Process '${java}' -ArgumentList '${javaargs}' -RedirectStandardError '${outfile}'"

  exec { 'javarunps':
    cwd       => $javapath,
    creates   => $outfile,
    command   => "${powershell} -Command \"${pscmd}\" ",
    path      => $pspath,
  }


}
