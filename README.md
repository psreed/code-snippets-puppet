# code-snippets-puppet
Snippets of useful puppetcode.

This is just a repo for me to dump example files and notes on puppet code that took me a while to figure out. Mostly sytax examples and things that are more complex than the simple examples provided in the standard puppet documentation.

# execwindowscmd.pp
# Exec Windows Command 
# (cmd.exe & powershell.exe examples)
<p>
This file is just an example file on how to run puppet exec resources on windows nodes. The purpose of this file isn't so much to show what's being run as it is an example of how to <b>properly use escape sequences for windows nodes</b>. These are just some complex examples on how those escapes work, because I don't ever want to fight that hard to figure them out again. 
</p>

# jre8viaarchive.pp
# Java JRE 8 via Archive Module 
# (.tar.gz extraction on Windows)
<p>
This file is an example of how to use the puppet-archive module on windows to extract a '.tar.gz'

On Linux nodes, the puppet-archive module uses the 'tar' command, which can extract a '.tar.gz' file in a single step.
On Windows nodes however, puppet-archive uses '7zip' which currently requires a 2-step process for these particular 
file types (this is a 7zip limitation). There may be other wrapped archive types that may also require this 
2-step method on Windows ('.cpio.tar' files maybe?).

</p>

# user-data.epp
# Amazon EC2 UserData EPP Template Example
<p>
This file is a Puppet EPP format template for AWS user-data for Windows and Linux.
Yes, one template for both. This has been migrated into my awsec2tags module (separate repo), but I'll just highlight the EPP template part it and leave that file here as an example. See my awsec2tags repo for a complete module with this included.
</p><br />
<strong>usage:</strong>
(Full puppet-aws module ec2_instance using this epp template example)
<pre>
ec2_instance { "myinstnace.example.com": 
  ensure               => present,
  region               => "us-west-2",
  availability_zone    => "us-west-2a",
  image_id             => "ami-id",
  instance_type        => "t2.small",
  key_name             => "your-key-name",
  security_groups      => ['standard-access'],
  tags                 =>  {
    "created_by"       => "paul.reed",
    "department"       => "tse",
    "project"          => "AWS Customer Demos & Testing",
  },
  <strong>user_data            => epp('demofiles/user-data.epp', {
    'puppet_master'    => 'master.example.com',
    'agent_certname'   => 'mynewclient.example.com',
    'os_type'          => 'Linux or Windows',
    'pp_preshared_key' => 'key, if using autosign',
    'pp_cloudplatform' => 'aws',
    'pp_role'          => 'role::my-role-for-this-host',
  }),</strong>
}
</pre>
